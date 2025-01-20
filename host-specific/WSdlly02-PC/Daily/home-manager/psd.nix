{
  lib,
  pkgs,
  ...
}: {
  services.psd.enable = true;
  systemd.user.services = let
    envPath = lib.makeBinPath (with pkgs; [
      glib
    ]);
  in {
    psd.Service.Environment = ["PATH=$PATH:${envPath}"];
    psd-resync.Service.Environment = ["PATH=$PATH:${envPath}"];
  };
}
