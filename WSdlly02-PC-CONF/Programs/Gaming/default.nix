{pkgs, ...}: {
  imports = [
    #./minecraft-server.nix
    ./openrazer.nix
  ];
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraEnv = {
          MANGOHUD = true;
        };
      };
      localNetworkGameTransfers.openFirewall = true;
      extest.enable = true;
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    java = {
      enable = true;
      package = pkgs.zulu;
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
}
