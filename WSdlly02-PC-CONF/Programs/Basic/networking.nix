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
      enable = true;
      fallbackDns = ["223.5.5.5" "117.50.11.11"];
      extraConfig = "MulticastDNS=no";
    };
  };
}
