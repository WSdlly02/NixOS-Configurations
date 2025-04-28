{
  imports = [
    ./Daily
    ./Gaming
    ./System
  ];
  hostSpecific = {
    enableDevelopment = true;
    enableInfrastructure = true;
  };
}
