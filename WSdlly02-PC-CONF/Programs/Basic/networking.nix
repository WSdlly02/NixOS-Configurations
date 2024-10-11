{lib, ...}: {
  networking = {
    hostName = "WSdlly02-PC";
    useDHCP = lib.mkDefault true;
    nftables.enable = true;
    tempAddresses = "disabled";
    firewall = {
      enable = true;
      allowedTCPPorts = [7890];
      allowedUDPPorts = [7890];
    };
    nameservers = ["127.0.0.1" "::1"];
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
