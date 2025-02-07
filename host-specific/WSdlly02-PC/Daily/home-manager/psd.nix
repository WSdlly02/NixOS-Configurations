{
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
          glib
          gnugrep
          gnused
          coreutils-full
          procps
          systemd
        ]
      );
    in
    {
      psd.Service.Environment = [
        "PATH=$PATH:${envPath}"
      ];
      psd-resync.Service.Environment = [
        "PATH=$PATH:${envPath}"
      ];
    };
}
