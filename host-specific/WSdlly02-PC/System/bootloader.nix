{
  pkgs,
  lib,
  ...
}:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "keep"; # "keep" seems equal to "auto"
      };
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
    };
    lanzaboote = {
      # Other configs will inherit automatically
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
  environment.systemPackages = [ pkgs.sbctl ];
}
