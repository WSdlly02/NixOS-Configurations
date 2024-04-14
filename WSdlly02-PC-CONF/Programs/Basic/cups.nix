{ callPackages, pkgs, ...}:

let
   epson_201601w = pkgs.callPackage ./epson_201601w.nix { };
in
{
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    browsing = false;
    defaultShared = false;
    openFirewall = false;
    drivers =  with pkgs; [
      epson_201601w 
    ];
  };
}
