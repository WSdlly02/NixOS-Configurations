{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    # hsphfpd.enable = true; Conflicts with wireplumber
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        FastConnectable = true;
        Experimental = true;
      };
    };
  };
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  /*
  nixpkgs.overlays = [
    (final: prev: {
      bluez = prev.bluez.override {enableExperimental = true;};
    })
  ];
  */
}
