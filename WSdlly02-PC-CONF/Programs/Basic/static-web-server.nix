{
  services.static-web-server = {
    enable = true;
    listen = "[::]:18787";
    root = "/home/wsdlly02/Documents/test/";
    configuration = {
      general = { 
        directory-listing = true;
        threads-multiplier = 1;
        log-remote-address = true;
        log-level = "error";
      };
    };
  };
}