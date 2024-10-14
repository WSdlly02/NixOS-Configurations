# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Hardware and drivers configuration
    ./Hardware/bluetooth.nix
    ./Hardware/gpu.nix
    ./Hardware/hardware-configuration.nix
    ./Hardware/localdisksmount.nix
    ##./Hardware/printer.nix
    ##./Hardware/remotefsmount.nix

    # Basic programs configuration
    ./Programs/Basic/avahi.nix
    ./Programs/Basic/basic.nix
    ##./Programs/Basic/cups.nix
    ##./Programs/Basic/gitDaemon.nix
    ./Programs/Basic/networking.nix
    ./Programs/Basic/networkmanager.nix
    ##./Programs/Basic/nix-ld.nix
    ./Programs/Basic/openssh.nix
    ./Programs/Basic/pipewire.nix
    ./Programs/Basic/plymouth.nix
    ./Programs/Basic/resolvconf.nix
    ##./Programs/Basic/samba.nix
    ./Programs/Basic/smartdns.nix
    ##./Programs/Basic/static-web-server.nix
    ./Programs/Basic/sudo.nix
    ./Programs/Basic/sysctl.nix
    ./Programs/Basic/tmux.nix
    ./Programs/Basic/zram.nix

    # Daily programs configuration
    ./Programs/Daily/cache2ram.nix
    ./Programs/Daily/chromium.nix
    ./Programs/Daily/daily.nix
    ./Programs/Daily/lact.nix
    ./Programs/Daily/fcitx5.nix
    ./Programs/Daily/plasma6.nix
    ./Programs/Daily/syncthing.nix
    ##./Programs/Daily/wine.nix

    # Development tools
    ##./Programs/Development/develop.nix

    # Gaming
    ./Programs/Gaming/gaming.nix
    ##./Programs/Gaming/minecraft-server.nix
    ./Programs/Gaming/openrazer.nix
  ];

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      gfxmodeEfi = "2560x1440";
      theme = pkgs.sleek-grub-theme;
      efiSupport = true;
      extraConfig = "set timeout=10";
      extraEntries = ''
        menuentry "Windows" --class windows {
          search --file --no-floppy --set=root /EFI/Microsoft/Boot/bootmgfw.efi
          chainloader (''${root})/EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry 'UEFI Firmware Settings' --class efi --id 'uefi-firmware'{
          fwsetup
        }
        menuentry "Restart" --class restart {
          echo "System rebooting..."
          reboot
        }
        menuentry "Shutdown" --class poweroff {
         echo "System shutting down..."
         halt
        }
      '';
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
  };

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "WSdlly02-PC"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  #console = {
  #font = "Lat2-Terminus16";
  #keyMap = "us";
  #useXkbConfig = true; # use xkb.options in tty.
  #};

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.videoDrivers = [ "amdgpu" ];

  #xdg.portal ={
  #  enable = true;
  #  xdgOpenUsePortal = true;
  #};

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_TIME = "zh_CN.UTF-8";
      LC_PAPER = "C.UTF-8";
    };
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };

  # services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services.fwupd.enable = true;
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  nix = {
    settings = {
      max-jobs = 64;
      substituters = lib.mkForce [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      auto-optimise-store = true;
      experimental-features = lib.mkForce [
        "nix-command"
        "flakes"
        "repl-flake" # 可以交互解释自己的配置：nix repl ~/nixos-config
      ];
    };
  };
  system.stateVersion = "24.05"; # Did you read the comment?
  system.name = "WSdlly02-PC";
}
