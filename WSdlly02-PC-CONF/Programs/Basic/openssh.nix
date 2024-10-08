{
  services.openssh = {
    enable = false;
    listenAddresses = [     
      {
        addr = "0.0.0.0";
        port = 10022;
      }
      {
        addr = "[::]";
        port = 10022;
      }
    ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PrintMotd = true;
    };
    authorizedKeysFiles = [ "/home/wsdlly02/.ssh/authorized_keys" ];
  };
}
