{
  config,
  lib,
  ...
}:
{
  networking = {
    hostName = config.system.name;
    nftables.enable = lib.mkDefault false;
    tempAddresses = "disabled";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        7890 # Mihomo
        12024 # Mincraft Server
        22000 # Syncthing
      ] ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") [ 8384 ];
      allowedTCPPortRanges =
        [
        ]
        ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") [
          {
            from = 10001;
            to = 10003;
            # ROC Source & Repair & Control ports
          }
        ];
      allowedUDPPorts = config.networking.firewall.allowedTCPPorts ++ [
        21027 # Syncthing
        22000
      ];
      allowedUDPPortRanges = config.networking.firewall.allowedTCPPortRanges;
    };
    timeServers = [
      "ntp.ntsc.ac.cn"
      "cn.ntp.org.cn"
    ];
    /*
      proxy = {
        default = "http://127.0.0.1:7890/";
        noProxy = "127.0.0.1,localhost,internal.domain";
      };
    */
  };
  services = {
    timesyncd.servers = config.networking.timeServers;
    resolved = {
      enable = true; # which will disable resolvconf
      domains = [ "~." ];
      fallbackDns = [
        "223.5.5.5"
        "119.29.29.29"
        "1.1.1.1"
        "9.9.9.9"
      ];
      extraConfig = ''
        Cache=yes
        CacheFromLocalhost=no
        ReadEtcHosts=yes
        MulticastDNS=false
      '';
    };
  };
}
