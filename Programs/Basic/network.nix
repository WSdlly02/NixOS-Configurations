{ config, lib, pkgs, ... }:

{
  networking.hostName = "WSdlly02-PC";
  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    #CFW ports
    allowedTCPPorts = [ 7890 ];
    allowedUDPPorts = [ 7890 ];
  };
  networking.nameservers = [ "127.0.0.1" "::1" ];
}