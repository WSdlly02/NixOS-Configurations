{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  #Fonts
  fonts.packages = with pkgs; [
    sarasa-gothic
  ];
  #Programs
  programs = {
    firefox.enable = true;
    noisetorch.enable = true;
    kdeconnect.enable = true;
  };
  environment.systemPackages = with pkgs; [
    fastfetch
    appimage-run
    steam-run
    konsole
    yakuake
    ark
    kate
    gwenview
    thunderbird
    microsoft-edge
    chromium
    motrix
    vulkan-tools
    fsearch
    qbittorrent
    element-desktop
    bilibili
    vscode
    obs-studio
    vlc
    mpv
    qq
    mission-center
    upscayl
    wpsoffice
  ];
}
