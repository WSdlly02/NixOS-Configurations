{lib, ...}: {
  services.openssh = {
    enable = true;
    ports = [10022];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      PrintMotd = true;
    };
    authorizedKeysFiles = ["/home/wsdlly02/.ssh/authorized_keys"];
  };
  systemd.services.sshd = {
    wantedBy = lib.mkForce [];
  };
}
