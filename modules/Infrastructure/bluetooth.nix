{
  pkgs,
  config,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = lib.mkIf (config.system.name == "WSdlly02-PC" || config.system.name == "WSdlly02-RaspberryPi5") true;
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
  systemd.user.services = lib.mkIf (config.system.name == "WSdlly02-PC" || config.system.name == "WSdlly02-RaspberryPi5") {
    mpris-proxy = {
      description = "Mpris proxy";
      after = ["network.target" "sound.target"];
      wantedBy = ["default.target"];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };
  /*
  nixpkgs.overlays = [
    (final: prev: {
      bluez = prev.bluez.override {enableExperimental = true;};
    })
  ];
  */
}
