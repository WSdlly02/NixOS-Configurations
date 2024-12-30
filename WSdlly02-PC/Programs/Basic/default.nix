{pkgs, ...}: {
  imports = [
    ./avahi.nix
    ##./cups.nix
    ##./gitDaemon.nix
    ./gnupg.nix
    ./neovim.nix
    ./networking.nix
    ./networkmanager.nix
    ##./nix-ld.nix
    ./openssh.nix
    ./pipewire.nix
    ./plymouth.nix
    ./proxychains.nix
    ##./samba.nix
    ##./smartdns.nix
    ##./static-web-server.nix
    ./sudo.nix
    ./sysctl.nix
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
    fstrim = {
      enable = true;
      interval = "weekly";
    };
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
        SystemMaxUse=512M
      '';
    };
  };

  environment.defaultPackages = with pkgs; [
    # Drivers and detection tools
    amdgpu_top
    aria2
    bind
    btop
    compsize
    cryptsetup
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
