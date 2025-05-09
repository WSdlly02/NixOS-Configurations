{ pkgs, ... }:
{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
          sddm-astronaut
        ];
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        theme = "sddm-astronaut-theme";
        settings.General.InputMethod = "qtvirtualkeyboard";
      };
    };
    desktopManager.plasma6.enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [ khelpcenter ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = [
      "kde"
    ];
  };
}
