{
  inputs,
  pkgs,
  ...
}:
{
  services.printing = {
    enable = true;
    /*
      startWhenNeeded = false;
      stateless = true;
      listenAddresses = [
        "0.0.0.0:631"
      ];
      allowFrom = [
        "192.168.71.*"
      ];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
      drivers = with pkgs; [
        inputs.self.packages."x86_64-linux".epson-inkjet-printer-201601w
      ];
    */
  };
}
