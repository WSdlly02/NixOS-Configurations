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
  nixpkgs.overlays = [
    (final: prev: {
      profile-sync-daemon = prev.profile-sync-daemon.overrideAttrs (finalAttrs: previousAttrs: {
        installPhase = previousAttrs.installPhase + "cp $out/share/psd/contrib/microsoft-edge $out/share/psd/browsers"; # Add microsoft-edge support
      });
    })
  ];
}
