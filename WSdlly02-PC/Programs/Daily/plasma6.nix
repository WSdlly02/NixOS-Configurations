{
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = ["amdgpu"];
    };
    displayManager.sddm = {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      autoNumlock = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
