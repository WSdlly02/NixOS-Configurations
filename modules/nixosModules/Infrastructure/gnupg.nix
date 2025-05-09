{
  lib,
  pkgs,
  enableInfrastructure,
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    programs.gnupg = {
      agent = {
        enable = true;
        #enableSSHSupport = true;
        #enableBrowserSocket = true;
        pinentryPackage = pkgs.pinentry-curses;
      };
    };
  };
}
