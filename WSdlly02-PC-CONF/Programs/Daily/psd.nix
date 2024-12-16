{pkgs, ...}: {
  systemd.user.services.psd = {
    enable = true;
    unitConfig = {
      Description = "Profile-sync-daemon";
      Documentation = "man:psd(1) man:profile-sync-daemon(1) https://wiki.archlinux.org/index.php/Profile-sync-daemon";
      Wants = ["psd-resync.service"];
      RequiresMountsFor = ["/home"];
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.profile-sync-daemon}/bin/profile-sync-daemon startup";
      ExecStop = "${pkgs.profile-sync-daemon}/bin/profile-sync-daemon unsync";
      Environment = ["LAUNCHED_BY_SYSTEMD=1" "PATH=/run/current-system/sw/bin:/run/wrappers/bin:${pkgs.glib.bin}/bin"];
    };
  };
  systemd.user.services.psd-resync = {
    enable = true;
    unitConfig = {
      Description = "Timed resync";
      After = ["psd.service"];
      Wants = ["psd-resync.timer"];
      BindsTo = ["psd.service"];
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.profile-sync-daemon}/bin/profile-sync-daemon resync";
      Environment = ["LAUNCHED_BY_SYSTEMD=1" "PATH=/run/current-system/sw/bin:/run/wrappers/bin:${pkgs.glib.bin}/bin"];
    };
  };
  systemd.user.timers.psd-resync = {
    unitConfig = {
      Description = "Timer for profile-sync-daemon - 1Hour";
      BindsTo = ["psd.service"];
    };
    timerConfig = {
      OnUnitActiveSec = "1h";
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
