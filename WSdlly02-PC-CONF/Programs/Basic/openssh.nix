{
  services.openssh = {
    enable = false;
    ports = [ 10022 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PrintMotd = true;
    };
    authorizedKeysFiles = [ "/home/wsdlly02/.ssh/authorized_keys" ];
  };
}
