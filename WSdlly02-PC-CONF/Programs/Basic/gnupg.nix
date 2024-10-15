{pkgs, ...}: {
  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
      enableBrowserSocket = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
