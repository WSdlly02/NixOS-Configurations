{ lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];


  # Enable the Plasma 6 Desktop Environment.
  services.xserver = {
    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      autoNumlock = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };
  xdg.portal ={
    enable = true;
    xdgOpenUsePortal = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
}