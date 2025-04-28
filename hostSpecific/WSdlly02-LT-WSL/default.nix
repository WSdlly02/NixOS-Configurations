{
  imports = [
    ./Daily
    ./System
  ];
  hostSpecific = {
    enableDevelopment = true;
    enableInfrastructure = false;
  };
}
