{ pkgs, ... }:
{
  imports = [
    ./i18n.nix
    ./neovim.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs-x86_64.nix
    ./sudo.nix
    ./tmux.nix
  ];
  wsl = {
    enable = true;
    defaultUser = "wsdlly02";
    interop.register = true;
    useWindowsDriver = true;
  };
  programs = {
    fish.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
    htop.enable = true;
  };
  services = {
    dbus.implementation = "broker";
    journald = {
      storage = "auto";
      extraConfig = ''
        Compress=true
        SystemMaxUse=512M
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    # Drivers and detection tools
    aria2
    btop
    dnsutils
    e2fsprogs
    iperf
    lm_sensors
    lsof
    nixfmt-rfc-style
    nix-output-monitor
    nix-tree
    nmap
    psmisc
    ripgrep
    rsync
    tree
    wget
  ];
}
