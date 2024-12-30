{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [pkgs.sbctl];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    # Other configs will inherit automatically
    enable = true;
    pkiBundle = "/var/lib/sbctl/";
  };
}
