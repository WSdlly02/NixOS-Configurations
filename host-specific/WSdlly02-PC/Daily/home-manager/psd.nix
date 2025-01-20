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
    psd.serviceConfig.Environment = ["PATH=$PATH:${envPath}"];
    psd-resync.serviceConfig.Environment = ["PATH=$PATH:${envPath}"];
  };
}
