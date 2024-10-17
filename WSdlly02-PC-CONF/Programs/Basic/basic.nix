{pkgs, ...}: {
  programs = {
    fuse.userAllowOther = true;
    fish.enable = true;
    vim.enable = true;
    vim.defaultEditor = true;
    git.enable = true;
    htop.enable = true;
    adb.enable = true;
  };
  services = {
    smartd.enable = true;
    dbus.implementation = "broker";
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [
        "/"
      ];
    };
  };
  systemd.sleep.extraConfig = ''
    MemorySleepMode=deep
  '';
  environment.systemPackages = with pkgs; [
    # Drivers and detection tools
    libva-utils
    vdpauinfo
    glxinfo
    ntfs3g
    sshfs-fuse
    usbutils
    pciutils
    lm_sensors
    amdgpu_top
    compsize # btrfs need
    # Basic programs
    wget
    dig
    ripgrep
    tree
    curl
    nmap
    lsof
    killall
    cryptsetup
    iperf
    zip
    unzip
    rsync
    corkscrew # ssh tunnel
    nix-output-monitor
    nix-tree
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
