{
  system.nssDatabases.hosts = [ "wins" ];
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      userServices = true;
      domain = true;
      addresses = true;
    };
    nssmdns6 = true;
    nssmdns4 = true;
    ipv6 = true;
    ipv4 = true;
  };
}