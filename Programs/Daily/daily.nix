{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    sarasa-gothic
    fastfetch
    appimage-run
    steam-run
    konsole
    yakuake
    gnome-network-displays
    ark
    kate
    gwenview
    libsForQt5.kdeconnect-kde
    thunderbird
    firefox
    microsoft-edge
    motrix
    vulkan-tools
    bilibili
    vscode
    obs-studio
    vlc
    mpv
    qq
    mission-center
  ];
}
