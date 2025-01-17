{
  config,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = lib.mkIf (config.system.name == "WSdlly02-PC" || config.system.name == "WSdlly02-RaspberryPi5") true;
    # hsphfpd.enable = true; Conflicts with wireplumber
    settings = {
      General = {
        Enable = lib.mkIf (config.system.name == "WSdlly02-PC") "Source,Sink,Media,Socket";
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
