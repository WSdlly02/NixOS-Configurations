{pkgs, ...}: {
  programs.proxychains = {
    enable = true;
    package = pkgs.proxychains-ng;
    quietMode = true;
    proxies."mihomo-party" = {
      enable = true;
      type = "http";
      host = "10.42.0.1";
      port = 7890;
    };
  };
}
