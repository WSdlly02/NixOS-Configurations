{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
    vkbasalt
    gamemode
    protonup-qt
    mindustry
    prismlauncher
    jdk21
  ];
}
