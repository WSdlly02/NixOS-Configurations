{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./avahi.nix
    ./bluetooth.nix
    ./ccache.nix
    ./getty.nix
    ##./gitDaemon.nix
    ./gnupg.nix
    ./i18n.nix
    ./neovim.nix
    ./networking.nix
    ./networkmanager.nix
    ./nix.nix
    ./openssh.nix
    ./pipewire.nix
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
    smartd.enable = lib.mkIf (pkgs.system == "x86_64-linux") true;
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
      extraConfig =
        let
          systemLogsMaxUse = if (pkgs.system == "x86_64-linux") then "512M" else "256M";
        in
        ''
          Compress=true
          SystemMaxUse=${systemLogsMaxUse}
        '';
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      # Drivers and detection tools
      aria2
      btop
      compsize
      cryptsetup
      dnsutils
      iperf
      lm_sensors
      lsof
      nixfmt-rfc-style
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
    ]
    ++ lib.optionals (config.system.name == "WSdlly02-PC") [
      amdgpu_top
      glxinfo
      lact # AMDGPU Fan Control
      libva-utils
      ntfs3g
      rar # ark required
      vdpauinfo
      vulkan-tools
    ]
    ++ lib.optionals (config.system.name == "WSdlly02-RaspberryPi5") [
      libraspberrypi
      i2c-tools
      raspberrypi-eeprom
    ];
}
