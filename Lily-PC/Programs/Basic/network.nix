{ lib, ... }:

{
  networking.hostName = "Lily-PC";
  networking.useDHCP = lib.mkDefault true;
  networking.nftables.enable = true;
  networking.tempAddresses = "disabled";
  networking.firewall = {
    enable = false;
    # CFW ports
    allowedTCPPorts = [ 7890 ];
    allowedUDPPorts = [ 7890 ];
  };
  networking.nameservers = [ "127.0.0.1" "::1" ];
}
