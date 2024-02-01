{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     #Drivers and detection tools
     ntfs3g
     sshfs-fuse
     usbutils
     pciutils
     lm_sensors
     smartmontools
     amdgpu_top
     #Basic programs
     sleek-grub-theme
     adi1090x-plymouth-themes
     vim
     git
     wget
     fish
     dig
     curl
     nmap
     lsof
     htop
     killall
     xz
     lz4
     zip
     unzip
     rsync
     tmux
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sleek-grub-theme = prev.sleek-grub-theme.override { withStyle = "dark"; withBanner = "WSdlly02-PC BootLoader"; };
      adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.override { selected_themes = ["rings"] ;};
    })
  ];
}
