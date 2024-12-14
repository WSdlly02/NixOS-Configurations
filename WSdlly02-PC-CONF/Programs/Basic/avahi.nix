{
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
    };
    nssmdns6 = true;
    nssmdns4 = true;
    ipv6 = true;
    ipv4 = true;
    extraConfig = ''
      [server]
      disallow-other-stacks=yes
    '';
  };
}
