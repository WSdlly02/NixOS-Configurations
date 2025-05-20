{ pkgs, ... }:
{
  imports = [
    ./Daily
    ./System
  ];
  hostSystemSpecific = {
    enableDevelopment = true;
    enableInfrastructure = false;
    environment.extraSystemPackages = with pkgs; [ wsl-open ];
    defaultUser = {
      name = "wsdlly02";
      linger = false;
      extraGroups = [ ];
    };
    nix.settings.max-jobs = 64;
  };
}
