{
  lib,
  pkgs,
  ...
}:
{
  services.psd.enable = true;
  systemd.user.services =
    let
      envPath = lib.makeBinPath (
        with pkgs;
        [
          coreutils-full
          gawk
          glib
          gnugrep
          gnused
          kmod
          nettools
          procps
          profile-sync-daemon
          rsync
          systemd
          util-linux
        ]
      );
    in
    {
      psd.Service.Environment = lib.mkForce [
        "LAUNCHED_BY_SYSTEMD=1"
        "PATH=${envPath}"
      ];
      psd-resync.Service.Environment = lib.mkForce [
        "LAUNCHED_BY_SYSTEMD=1"
        "PATH=${envPath}"
      ];
    };
}
