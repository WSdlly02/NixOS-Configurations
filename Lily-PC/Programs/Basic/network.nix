{ lib, ... }:

{
  networking.hostName = "Lily-PC";
  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.tempAddresses = "disabled";
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 7890 18787 12024 22024 19418 ];
    #                   CFW  SWS   MC    MC_RCON gitDaemon
    allowedUDPPorts = [ 7890 18787 12024 22024 19418 ];
  };
  networking.nameservers = [ "127.0.0.1" "::1" ];
}
