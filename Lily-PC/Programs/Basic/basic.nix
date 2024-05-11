{ pkgs, ... }:

{
  programs ={
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
     usbutils
     pciutils
     lm_sensors
     ##smartmontools
     # Basic programs
     sleek-grub-theme
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
     coreutils-full
     xz
     lz4
     zip
     unzip
     rsync
     gnugrep
     gawk
     gnused
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sleek-grub-theme = prev.sleek-grub-theme.override { withStyle = "dark"; withBanner = "GRUB BootLoader"; };
    })
  ];
}
