{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ccache = {
    enable = true;
    packageNames =
      [
      ]
      ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") ["linuxKernel.kernels.linux-rpi5"];
  };
}
