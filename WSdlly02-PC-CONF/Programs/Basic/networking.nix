{lib, ...}: {
  networking = {
    hostName = "WSdlly02-PC";
    useDHCP = lib.mkDefault true;
    nftables.enable = lib.mkDefault false;
    tempAddresses = "disabled";
    firewall = {
      enable = true;
      allowedTCPPorts = [7890];
      allowedUDPPorts = [7890];
    };
    timeServers = [
      "ntp.ntsc.ac.cn"
      "cn.ntp.org.cn"
    ];
  };
  services.resolved = {
    enable = true;
    fallbackDns = ["223.5.5.5"];
    extraConfig = "MulticastDNS=no";
  };
}
