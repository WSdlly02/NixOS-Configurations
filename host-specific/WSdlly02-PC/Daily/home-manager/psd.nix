{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.psd = {
    enable = true;
    browsers = [
      "firefox"
      "google-chrome"
      "microsoft-edge"
      "vscode"
      "zen"
    ];
    backupLimit = 2;
    resyncTimer = "30min";
  };
  xdg.configFile."psd/psd.conf".text = ''
    USE_OVERLAYFS="yes"
    USE_SUSPSYNC="yes"
  '';
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
    rec {
      psd.Service.Environment = lib.mkForce [
        "LAUNCHED_BY_SYSTEMD=1"
        "PATH=${envPath}"
      ];
      psd-resync.Service.Environment = psd.Service.Environment;
    };
}
