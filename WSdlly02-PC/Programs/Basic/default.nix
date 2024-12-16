{pkgs, ...}: {
  imports = [
    ./avahi.nix
    ##./cups.nix
    ##./gitDaemon.nix
    ./gnupg.nix
    ./networking.nix
    ./networkmanager.nix
    ##./nix-ld.nix
    ./openssh.nix
    ./pipewire.nix
    ./plymouth.nix
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
    vim = {
      enable = true;
      defaultEditor = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
    };
    htop.enable = true;
    bandwhich.enable = true;
    # usbtop.enable = true;
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
    killall
    libva-utils
    lact # AMDGPU Fan Control
    lm_sensors
    lsof
    modprobed-db
    nix-output-monitor
    nix-tree
    nmap
    ntfs3g
    pciutils
    rar
    ripgrep
    rsync
    sshfs-fuse
    tree
    proxychains-ng
    unzip
    usbutils
    vdpauinfo
    vulkan-tools
    wget
    zip
  ];
  nixpkgs.overlays = [
    (final: prev: {
      adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.override {selected_themes = ["hexagon_dots"];};
    })
  ];
}
