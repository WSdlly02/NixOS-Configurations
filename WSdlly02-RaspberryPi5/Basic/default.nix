{pkgs, ...}: {
  imports = [
    ./avahi.nix
    ./cups.nix
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
    smartd.enable = true;
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
    amdgpu_top
    aria2
    btop
    compsize
    cryptsetup
    dnsutils
    e2fsprogs
    glxinfo
    iperf
    lact # AMDGPU Fan Control
    libva-utils
    lm_sensors
    lsof
    modprobed-db
    nix-output-monitor
    nix-tree
    nmap
    ntfs3g
    pciutils
    psmisc
    rar
    ripgrep
    rsync
    sshfs
    tree
    usbutils
    vdpauinfo
    vulkan-tools
    wget
  ];
}
