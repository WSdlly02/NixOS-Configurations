{
  services.static-web-server = {
    enable = true;
    listen = "[::]:18787";
    root = "/home/lily/static-web-server-dir/";
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
