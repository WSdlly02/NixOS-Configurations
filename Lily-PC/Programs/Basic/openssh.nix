{
  services.openssh = {
    enable = true;
    listenAddresses = [     
      {
        addr = "0.0.0.0";
        port = 22;
      }
      {
        addr = "[::]";
        port = 22;
      }
    ];
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
    authorizedKeysFiles = [ "/home/lily/.ssh/authorized_keys" ];
  };
}
