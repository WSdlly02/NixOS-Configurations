{ config, lib, pkgs, ... }:

{
  networking.hostName = "WSdlly02-PC";
  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.tempAddresses = "disabled";
  networking.firewall = {
    enable = false;
    #CFW ports
    allowedTCPPorts = [ 7890 ];
    allowedUDPPorts = [ 7890 ];
  };
  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.extraHosts = ''
    20.196.210.19 bing.com
    20.196.210.19 www.bing.com
    20.196.210.19 r.bing.com
    20.196.210.19 cn.bing.com
    20.196.210.19 edgeservices.bing.com
    20.196.210.19 sydney.bing.com
  '';
}