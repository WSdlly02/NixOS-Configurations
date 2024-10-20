{pkgs, ...}: {
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

  systemd.sleep.extraConfig = ''
    MemorySleepMode=deep
  '';
  environment.defaultPackages = with pkgs; [
    # Drivers and detection tools
    amdgpu_top
    bind
    btop
    compsize
    corkscrew
    cryptsetup
    glxinfo
    iperf
    killall
    libva-utils
    lact # AMDGPU Fan Control
    lm_sensors
    lsof
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
    unrar
    unzip
    usbutils
    vdpauinfo
    vulkan-tools
    wget
    zip
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sleek-grub-theme = prev.sleek-grub-theme.override {
        withStyle = "dark";
        withBanner = "GRUB BootLoader";
      };
      adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.override {selected_themes = ["hexagon_dots"];};
    })
  ];
}
