{
  config,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = lib.mkIf (config.system.name == "WSdlly02-PC" || config.system.name == "WSdlly02-RaspberryPi5") true;
    powerOnBoot = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") false;
    # hsphfpd.enable = true; Conflicts with wireplumber
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        FastConnectable = true;
        Experimental = true;
      };
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
