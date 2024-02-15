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
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      appimage-run
      steam-run
      python310
      konsole
      yakuake
      ark
      kate
      gwenview
      libsForQt5.sddm-kcm
      thunderbird
      microsoft-edge
      chromium
      yesplaymusic
      g4music
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
  };
}
