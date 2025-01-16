{
  pkgs,
  lib,
  ...
}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = lib.mkForce false;
        consoleMode = "auto";
      };
      timeout = 10;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };
    };
    lanzaboote = {
      # Other configs will inherit automatically
      enable = true;
      pkiBundle = "/var/lib/sbctl/";
    };
  };
  environment.systemPackages = [pkgs.sbctl];
}
