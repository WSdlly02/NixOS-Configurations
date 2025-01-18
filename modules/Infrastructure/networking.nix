{
  config,
  lib,
  ...
}: {
  networking = {
    hostName = config.system.name;
    nftables.enable = lib.mkDefault false;
    tempAddresses = "disabled";
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts =
        [
          7890 # Mihomo
          12024 # Mincraft Server
        ]
        ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") [
          10001
          10002
          10003
        ];
      allowedUDPPorts = config.networking.firewall.allowedTCPPorts;
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
      fallbackDns = [
        "223.5.5.5"
        "119.29.29.29"
        "1.1.1.1"
        "9.9.9.9"
      ];
      extraConfig = ''
        MulticastDNS=no
      '';
    };
  };
}
