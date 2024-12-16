{pkgs, ...}: {
  services.psd.enable = true;
  systemd.user.services = {
    psd = {
      path = with pkgs; [
        glib
      ];
      serviceConfig = {Environment = ["LAUNCHED_BY_SYSTEMD=1"];};
    };
    psd-resync = {
      path = with pkgs; [
        glib
      ];
      serviceConfig = {Environment = ["LAUNCHED_BY_SYSTEMD=1"];};
    };
  };
  nixpkgs.overlays = [
    (final: prev: {
      profile-sync-daemon = prev.profile-sync-daemon.overrideAttrs (finalAttrs: previousAttrs: {
        installPhase = previousAttrs.installPhase + "cp $out/share/psd/contrib/microsoft-edge $out/share/psd/browsers"; # Add microsoft-edge support
      });
    })
  ];
}
