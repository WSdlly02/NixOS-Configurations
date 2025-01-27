{
  config,
  lib,
  ...
}:
{
  programs.ccache = {
    enable = true;
    packageNames = [
    ] ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") [ "linux_rpi5" ];
    # Which adds ccacheStdenv to overlays
  };
}
