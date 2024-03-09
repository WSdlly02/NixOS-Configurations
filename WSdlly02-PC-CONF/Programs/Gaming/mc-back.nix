{
  services.minecraft-server = {
    enable = true;
    package = pkgs.minecraft-server;
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
      enable-rcon = false;
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
      max-players = 8;
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
      rcon.password = "MC_SE_LIangyicheng02";
      rcon.port = 22024;
      require-resource-pack=false;
      ##resource-pack = ;
      ##resource-pack-prompt = ;
      ##resource-pack-sha1=;
      ##server-ip=;
      server-port = 2024;
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
  nixpkgs.overlays = [
    (final: prev: {
      minecraft-server = prev.minecraft-server.overrideAttrs (oldAttrs: {
        version = "1.20.2";
        getJavaVersion = 21;
        src = prev.fetchurl { 
          url = "https://meta.fabricmc.net/v2/versions/loader/1.20.2/0.15.7/1.0.0/server/jar";
          sha1 = "856cfeedcc5f1ede7ff6e94dd1975cdbb63b4286";
        };
      });
    })
  ];
}
