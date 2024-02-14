{ config, pkgs, ... }:

{
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
    vkbasalt
    gamemode
    protonup-qt
    mindustry
    prismlauncher
  ];
}
