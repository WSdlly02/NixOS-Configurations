{
  system.nssDatabases.hosts = [ "mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns wins" ];
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