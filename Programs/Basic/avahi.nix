{
  system.nssDatabases.hosts = [ "mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns wins" ];
  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      workstation = true;
    };
    nssmdns = true;
    ipv6 = true;
    ipv4 = true;
  };
}