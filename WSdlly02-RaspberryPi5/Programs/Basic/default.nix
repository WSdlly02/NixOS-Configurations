{pkgs, ...}: {
  imports = [
    ./avahi.nix
    ./getty.nix
    ./gnupg.nix
    ./i18n.nix
    ./neovim.nix
    ./networking.nix
    ./networkmanager.nix
    ./openssh.nix
    ./pipewire.nix
    ./proxychains.nix
    ./sudo.nix
    ./sysctl.nix
    ./system.nix
    ./tmux.nix
  ];

  programs = {
    fuse.userAllowOther = true;
    fish.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
    htop.enable = true;
    bandwhich.enable = true;
    usbtop.enable = true;
    adb.enable = true;
  };
  services = {
    fstrim.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [
        "/"
      ];
    };
    dbus.implementation = "broker";
    journald = {
      storage = "auto";
      extraConfig = ''
        Compress=true
        SystemMaxUse=256M
      '';
    };
  };

  environment.defaultPackages = with pkgs; [
    # Drivers and detection tools
    aria2
    btop
    compsize
    cryptsetup
    dnsutils
    # e2fsprogs
    iperf
    libraspberrypi
    lm_sensors
    lsof
    nix-output-monitor
    nix-tree
    nmap
    pciutils
    psmisc
    ripgrep
    rsync
    sshfs
    tree
    usbutils
    wget
  ];
}
