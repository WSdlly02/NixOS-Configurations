{
  config,
  lib,
  ...
}: {
  networking = {
    hostName = "WSdlly02-PC";
    nftables.enable = lib.mkDefault false;
    tempAddresses = "disabled";
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [7890];
      allowedUDPPorts = [7890];
    };
    timeServers = [
      "ntp.ntsc.ac.cn"
      "cn.ntp.org.cn"
    ];
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
