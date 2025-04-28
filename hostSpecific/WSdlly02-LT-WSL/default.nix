{
  imports = [
    ./Daily
    ./System
  ];
  hostSpecific = {
    enableDevelopment = true;
    enableInfrastructure = false;
    defaultUser = {
      name = "wsdlly02";
      linger = false;
      extraGroups = [ ];
    };
    nix.settings.max-jobs = 64;
  };
}
