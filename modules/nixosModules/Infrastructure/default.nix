{
  config,
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
        command-not-found.dbPath = "${pkgs.self.outPath}/programs.sqlite";
        fish.enable = true;
        git = {
          enable = true;
          lfs.enable = true;
        };
        htop.enable = true;
        lazygit.enable = true;
        nix-ld.enable = true;
      };
      services = {
        smartd.enable = config.hostSystemSpecific.enableSmartd;
        fstrim.enable = true;
        btrfs.autoScrub = lib.mkIf config.hostSystemSpecific.enableBtrfsScrub {
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
              systemLogsMaxUse =
                if ("${pkgs.stdenv.hostPlatform.system}" == "x86_64-linux") then "512M" else "256M";
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
          currentNixConfig
          dnsutils
          fzf
          iperf
          lm_sensors
          lsof
          # nixd
          # nixfmt-rfc-style
          # nix-diff
          # nix-output-monitor
          # nix-tree
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
        ++ config.hostSystemSpecific.environment.extraSystemPackages;
    }
  ];
}
