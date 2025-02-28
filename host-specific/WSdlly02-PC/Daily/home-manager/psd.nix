{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.psd;
  configFile = ''
    USE_OVERLAYFS="yes"
    USE_SUSPSYNC="yes"
    ${lib.optionalString (cfg.browsers != [ ]) ''BROWSERS=(${lib.concatStringsSep " " cfg.browsers})''}
    USE_BACKUPS="${if cfg.useBackup then "yes" else "no"}"
    BACKUP_LIMIT=${builtins.toString cfg.backupLimit}
  '';
in
{
  services.psd = {
    enable = true;
    browsers = [
      "firefox"
      "google-chrome"
      "microsoft-edge"
    ];
    backupLimit = 2;
    resyncTimer = "30min";
  };
  xdg.configFile."psd/psd.conf".text = lib.mkForce configFile;
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
