{
  config,
  lib,
  pkgs,
  enableInfrastructure,
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    programs.proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      quietMode = true;
      proxies."mihomo-party" = {
        enable = true;
        type = "http";
        host = config.hostSpecific.programs.proxychains.proxies.host;
        port = 7890;
      };
    };
  };
}
