{
  config,
  lib,
  ...
}:
{
  hardware.bluetooth = {
    enable = lib.mkIf (
      config.system.name == "WSdlly02-PC" || config.system.name == "WSdlly02-RaspberryPi5"
    ) true;
    # hsphfpd.enable = true; Conflicts with wireplumber
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        JustWorksRepairing = "always";
        MultiProfile = "multiple";
        FastConnectable = true;
        KernelExperimental = true;
        Experimental = true;
      };
    };
  };
  # services.mpris-proxy.enable is defined in home-manager
  /*
    nixpkgs.overlays = [
      (final: prev: {
        bluez = prev.bluez.override {enableExperimental = true;};
      })
    ];
  */
}
