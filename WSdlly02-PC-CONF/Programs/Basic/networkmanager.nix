{
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    ethernet.macAddress = "permanent";
    wifi.macAddress = "permanent";
    /*
      settings = {
      main = {hostname = "WSdlly02-PC";}; # For Privacy
    };
    */
  };
}
