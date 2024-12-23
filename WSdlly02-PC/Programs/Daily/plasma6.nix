{
  lib,
  pkgs,
  ...
}: {
  services = {
    displayManager.sddm = {
      enable = true;
      package = lib.mkForce pkgs.kdePackages.sddm;
      autoNumlock = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    desktopManager.plasma6.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    khelpcenter
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
