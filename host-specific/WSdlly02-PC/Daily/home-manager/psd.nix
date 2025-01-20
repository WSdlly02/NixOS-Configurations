{
  lib,
  pkgs,
  ...
}: {
  services.psd.enable = true;
  systemd.user.services = let
    envPath = lib.makeBinPath (with pkgs; [
      glib
      gnugrep
      gnused
      rsync
      kmod
      gawk
      coreutils-full
      procps
      nettools
      systemd
      util-linux
      profile-sync-daemon
    ]);
  in {
    psd.Service.Environment = lib.mkForce ["LAUNCHED_BY_SYSTEMD=1" "PATH=$PATH:${envPath}"];
    psd-resync.Service.Environment = lib.mkForce ["LAUNCHED_BY_SYSTEMD=1" "PATH=$PATH:${envPath}"];
  };
}
