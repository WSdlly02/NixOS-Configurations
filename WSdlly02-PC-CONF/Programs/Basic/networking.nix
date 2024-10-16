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
    nameservers = ["127.0.0.1" "::1"];
    timeServers = [
      "ntp.ntsc.ac.cn"
      "cn.ntp.org.cn"
    ];
    extraHosts = ''
      20.196.210.19 bing.com
      20.196.210.19 www.bing.com
      20.196.210.19 r.bing.com
      20.196.210.19 cn.bing.com
      20.196.210.19 edgeservices.bing.com
      20.196.210.19 sydney.bing.com
    '';
  };
}
