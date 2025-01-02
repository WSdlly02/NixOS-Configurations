# Just for nixos-options
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Hardware and drivers configuration
    ./Hardware
    # Basic programs configuration
    ./Programs/Basic
    # Daily programs configuration
    ./Programs/Daily
    # Development tools
    ./Programs/Development
    # Gaming
    ./Programs/Gaming
  ];
}
