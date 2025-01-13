{pkgs, ...}: {
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    quietMode = true;
    proxies."mihomo-party" = {
      enable = true;
      type = "http";
      host = "127.0.0.1";
      port = 7890;
    };
  };
}
