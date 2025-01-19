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
      ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") ["linux-rpi5"];
  };
}
