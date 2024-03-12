{ callPackages, pkgs, ...}:

let
   epson_201601w = pkgs.callPackage ./epson_201601w.nix { };
in
{
  services.printing = {
    enable = true;
    startWhenNeeded = false;
    listenAddresses = [
      "0.0.0.0:631"
    ];
    allowFrom = [
      "192.168.71.*"
    ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
    drivers =  with pkgs; [
      epson_201601w 
    ];
  };
}