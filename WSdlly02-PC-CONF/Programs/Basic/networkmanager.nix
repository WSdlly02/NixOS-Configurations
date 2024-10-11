{
  networking.networkmanager = {
    enable = true;
    dns = "none";
    ethernet.macAddress = "permanent";
    wifi.macAddress = "permanent";
    /*
      settings = {
      keyfile = {hostname = "WSdlly02-PC";}; # For Privacy
    };
    */
  };
}
