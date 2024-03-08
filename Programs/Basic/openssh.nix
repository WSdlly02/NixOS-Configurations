{
  services.openssh = {
    enable = true;
    ##startWhenNeeded = true;
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
    authorizedKeysFiles = [ "/home/wsdlly02/.ssh/authorized_keys" ];
  };
}