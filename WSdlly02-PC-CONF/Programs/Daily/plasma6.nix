{ lib, pkgs, ... }:

{
  # Enable the Plasma 6 Desktop Environment.
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
      displayManager.sddm = {
        enable = true;
        #package = lib.mkForce pkgs.kdePackages.sddm;
        autoNumlock = true;
      };
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
}