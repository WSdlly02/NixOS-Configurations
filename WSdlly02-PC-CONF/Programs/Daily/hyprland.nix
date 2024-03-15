{ pkgs, ...}:

{
  programs = {
    hyprland.enable = true;
    waybar.enable = true;
  };
  environment.defaultPackages = with pkgs; [
    hyprpaper
    tofi
    mako
    brightnessctl
    kdePackages.polkit-kde-agent-1
    networkmanagerapplet
    hyprshot
    power-profiles-daemon
    swayidle
    swaylock
    wlogout
    cliphist
  ];
  services.udisks2.enable = true;
}