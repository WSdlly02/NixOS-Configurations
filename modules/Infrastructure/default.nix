{
  config,
  inputs,
  lib,
  pkgs,
  enableInfrastructure,
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

  config = lib.mkMerge [
    (lib.mkIf enableInfrastructure {
      programs = {
        fuse.userAllowOther = true;
        bandwhich.enable = true;
        usbtop.enable = true;
        adb.enable = true;
      };
    })
    {
      programs = {
        fish.enable = true;
        git = {
          enable = true;
          lfs.enable = true;
        };
        htop.enable = true;
      };
      services = {
        smartd.enable = config.hostSpecific.enableSmartd;
        fstrim.enable = true;
        btrfs.autoScrub = lib.mkIf config.hostSpecific.enableBtrfsScrub {
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
              systemLogsMaxUse = if (pkgs.stdenv.hostPlatform.system == "x86_64-linux") then "512M" else "256M";
            in
            ''
              Compress=true
              SystemMaxUse=${systemLogsMaxUse}
            '';
        };
      };
      environment.pathsToLink = [ "${inputs.self}" ];
      environment.systemPackages =
        with pkgs;
        [
          # Drivers and detection tools
          aria2
          btop
          compsize
          cryptsetup
          dnsutils
          fzf
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
        ++ config.hostSpecific.environment.extraSystemPackages;
    }
  ];
}
