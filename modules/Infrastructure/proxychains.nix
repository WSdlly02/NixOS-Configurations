{
  pkgs,
  config,
  ...
}: {
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    quietMode = true;
    proxies."mihomo-party" = {
      enable = true;
      type = "http";
      host =
        if config.system.name != "WSdlly02-RaspberryPi5"
        then "127.0.0.1"
        else "10.42.0.1";
      port = 7890;
    };
  };
}
