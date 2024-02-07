{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  #Fonts
  fonts.packages = with pkgs; [
    sarasa-gothic
  ];
  #Programs
  programs.firefox.enable = true;
  programs.noisetorch.enable = true;
  programs.kdeconnect.enable = true;
  services.syncthing.enable = true;
  environment.systemPackages = with pkgs; [
    fastfetch
    appimage-run
    steam-run
    konsole
    yakuake
    gnome-network-displays
    ark
    kate
    gwenview
    #libsForQt5.kdeconnect-kde
    thunderbird
    #firefox
    microsoft-edge
    motrix
    vulkan-tools
    qbittorrent
    #noisetorch
    bilibili
    vscode
    obs-studio
    vlc
    mpv
    qq
    mission-center
    upscayl
  ];
}
