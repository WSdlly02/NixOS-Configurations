{ pkgs, ... }:

{
  programs ={
    fuse.userAllowOther = true;
    fish.enable = true;
    bash.enableCompletion = true;
    vim.defaultEditor = true;
    git.enable = true;
    htop.enable = true;
    adb.enable = true;
  };
  services = {
    smartd.enable = true;
    dbus.implementation = "broker";
  };
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
     ##smartmontools
     amdgpu_top
     # Basic programs
     sleek-grub-theme
     adi1090x-plymouth-themes
     vim
     ##git
     wget
     ##fish
     dig
     curl
     nmap
     lsof
     ##htop
     killall
     cryptsetup
     xz
     lz4
     zip
     unzip
     rsync
     gcc-unwrapped
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sleek-grub-theme = prev.sleek-grub-theme.override { withStyle = "dark"; withBanner = "GRUB BootLoader"; };
      adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.override { selected_themes = ["red_loader"] ;};
    })
  ];
}
