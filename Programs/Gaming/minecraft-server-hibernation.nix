{ callPackage, config, lib, pkgs, modulesPath, ... }:
let

  # check every 30 seconds if the server
  # need to be stopped
  frequency-check-players = "*-*-* *:*:0/30";

  # time in second before we could stop the server
  # this should let it time to spawn
  minimum-server-lifetime = 600;

  # minecraft port
  # used in a few places in the code
  # this is not the port that should be used publicly
  # don't need to open it on the firewall
  minecraft-port = 25564;

  # this is the port that will trigger the server start
  # and the one that should be used by players
  # you need to open it in the firewall
  public-port = 2024;

  # a rcon password used by the local systemd commands
  # to get information about the server such as the
  # player list
  # this will be stored plaintext in the storeMC_SE_LIangyicheng02
  rcon-password = "MC_SE_LIangyicheng02";

  # a script used by hook-minecraft.service
  # to start minecraft and the timer regularly
  # polling for stopping it
  start-mc = pkgs.writeShellScriptBin "start-mc" ''
    systemctl start minecraft-server.service
    systemctl start stop-minecraft.timer
  '';

  # wait 60s for a TCP socket to be available
  # to wait in the proxifier
  # idea found in https://blog.developer.atlassian.com/docker-systemd-socket-activation/
  wait-tcp = pkgs.writeShellScriptBin "wait-tcp" ''
    for i in `seq 60`; do
      if ${pkgs.libressl.nc}/bin/nc -z 127.0.0.1 ${toString minecraft-port} > /dev/null ; then
        exit 0
      fi
      ${pkgs.busybox.out}/bin/sleep 1
    done
    exit 1
  '';

  # script returning true if the server has to be shutdown
  # for minecraft, uses rcon to get the player list
  # skips the checks if the service started less than minimum-server-lifetime
  no-player-connected = pkgs.writeShellScriptBin "no-player-connected" ''
    servicestartsec=$(date -d "$(systemctl show --property=ActiveEnterTimestamp minecraft-server.service | cut -d= -f2)" +%s)
    serviceelapsedsec=$(( $(date +%s) - servicestartsec))

    # exit if the server started less than 5 minutes ago
    if [ $serviceelapsedsec -lt ${toString minimum-server-lifetime} ]
    then
      echo "server is too young to be stopped"
      exit 1
    fi

    PLAYERS=`printf "list\n" | ${pkgs.rcon.out}/bin/rcon -m -H 127.0.0.1 -p 22024 -P ${rcon-password}`
    if echo "$PLAYERS" | grep "are 0 of a"
    then
      exit 0
    else
      exit 1
    fi
  '';

in
{
  # use NixOS module to declare your Minecraft
  # rcon is mandatory for no-player-connected
  services.minecraft-server = {
    enable = true;
    package = pkgs.callPackage ./minecraft-server-fabric.nix { };
    ##jvmOpts = "-Xms4092M -Xmx4092M -XX:+UseG1GC -XX:+CMSIncrementalPacing -XX:+CMSClassUnloadingEnabled -XX:ParallelGCThreads=2 -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10";
    declarative = true;
    dataDir = "/srv/minecraft";
    eula = true;
    openFirewall = true;
    serverProperties = {
      allow-flight = false;
      allow-nether = true;
      broadcast-console-to-ops = true;
      broadcast-rcon-to-ops = true;
      difficulty = "hard";
      enable-command-block = true;
      enable-jmx-monitoring = false;
      enable-query = true;
      enable-rcon = true;
      enable-statu = true;
      enforce-secure-profile = true;
      enforce-whitelist = false;
      entity-broadcast-range-percentage = 100;
      force-gamemode = false;
      function-permission-level = 2;
      gamemode = "survival";
      generate-structures = true;
      ##generator-settings = {};
      hardcore = false;
      hide-online-players = false;
      ##initial-disabled-packs = ;
      initial-enabled-packs = "vanilla";
      level-name = "world";
      ##level-seed = ;
      level-type = "minecraft\:normal";
      log-ips = true;
      max-chained-neighbor-updates = 1000000;
      max-players = 16;
      max-tick-time = 60000;
      max-world-size = 29999984;
      motd = "WSdlly02-SE-LO";
      network-compression-threshold = 256;
      online-mode = true;
      op-permission-level = 4;
      player-idle-timeout = 0;
      prevent-proxy-connections = false;
      pvp = true;
      "query.port" = 2024;
      rate-limit = 0;
      "rcon.password" = rcon-password;
      "rcon.port" = 22024;
      require-resource-pack=false;
      ##resource-pack = ;
      ##resource-pack-prompt = ;
      ##resource-pack-sha1=;
      ##server-ip=;
      server-port = minecraft-port;
      simulation-distance = 10;
      spawn-animals = true;
      spawn-monsters = true;
      spawn-npcs = true;
      spawn-protection = 16;
      sync-chunk-writes = true;
      ##text-filtering-config = ;
      use-native-transport = true;
      view-distance = 10;
      white-list = true;
    };
    whitelist = {
      WSdlly02 = "2d4b4759-54e8-4304-8434-2ae02fdd0537";
      beclcolud = "080af814-0c31-4241-9a76-23bef4764f77";
      ZoD1AC0 = "5ffa6f38-b847-4ea7-b909-8f617e77d079";
      iven233 = "dfa30c4c-a23b-4e72-ae74-f329536e99f7";
    };
  };

  # don't start Minecraft on startup
  systemd.services.minecraft-server = {
      wantedBy = pkgs.lib.mkForce [];
  };

  # this waits for incoming connection on public-port
  # and triggers listen-minecraft.service upon connection
  systemd.sockets.listen-minecraft = {
    enable = true;
    wantedBy = [ "sockets.target" ];
    requires = [ "network.target" ];
    listenStreams = [ "${toString public-port}" ];
  };

  # this is triggered by a connection on TCP port public-port
  # start hook-minecraft if not running yet and wait for it to return
  # then, proxify the TCP connection to the real Minecraft port on localhost
  systemd.services.listen-minecraft = {
    path = with pkgs; [ systemd ];
    enable = true;
    requires = [ "hook-minecraft.service" "listen-minecraft.socket" ];
    after =    [ "hook-minecraft.service" "listen-minecraft.socket"];
    serviceConfig.ExecStart = "${pkgs.systemd.out}/lib/systemd/systemd-socket-proxyd 127.0.0.1:${toString minecraft-port}";
  };

  # this starts Minecraft is required
  # and wait for it to be available over TCP
  # to unlock listen-minecraft.service proxy
  systemd.services.hook-minecraft = {
    path = with pkgs; [ systemd libressl busybox ];
    enable = true;
    serviceConfig = {
        ExecStartPost = "${wait-tcp.out}/bin/wait-tcp";
        ExecStart     = "${start-mc.out}/bin/start-mc";
    };
  };

  # create a timer running every frequency-check-players
  # that runs stop-minecraft.service script on a regular
  # basis to check if the server needs to be stopped
  systemd.timers.stop-minecraft = {
    enable = true;
    timerConfig = {
      OnCalendar = "${frequency-check-players}";
      Unit = "stop-minecraft.service";
    };
    wantedBy = [ "timers.target" ];
  };

  # run the script no-player-connected
  # and if it returns true, stop the minecraft-server
  # but also the timer and the hook-minecraft service
  # to prepare a working state ready to resume the
  # server again
  systemd.services.stop-minecraft = {
    enable = true;
    serviceConfig.Type = "oneshot";
    script = ''
      if ${no-player-connected}/bin/no-player-connected
      then
        echo "stopping server"
        systemctl stop minecraft-server.service
        systemctl stop hook-minecraft.service
        systemctl stop stop-minecraft.timer
      fi
    '';
  };

}