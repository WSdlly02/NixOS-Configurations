{ callpackages, pkgs, ... }:

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
      package = (pkgs.callPackage ./zulu-22.nix { });
    };
  };
  environment.defaultPackages = with pkgs; [
    mangohud
    goverlay
    vkbasalt
    protonup-qt
    mindustry
    prismlauncher
    mcrcon
  ];
  systemd.tmpfiles.rules = [
    "z  /sys/class/powercap/intel-rapl:0/energy_uj  0404  -  -  -  -"
  ];
}
