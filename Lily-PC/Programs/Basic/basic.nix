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
  services.smartd.enable = true;
  environment.systemPackages = with pkgs; [
     # Drivers and detection tools
     ntfs3g
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
     xz
     lz4
     zip
     unzip
     rsync
     gnumake
     gcc-unwrapped
     modprobed-db
  ];
  nixpkgs.overlays = [
    (final: prev: {
      sleek-grub-theme = prev.sleek-grub-theme.override { withStyle = "dark"; withBanner = "GRUB BootLoader"; };
    })
  ];
}
