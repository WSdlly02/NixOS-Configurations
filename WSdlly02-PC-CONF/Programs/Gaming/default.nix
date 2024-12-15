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
      package = pkgs.zulu21;
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
  nixpkgs.overlays = [
    (final: prev: {
      mindustry = prev.mindustry.override {jdk17 = pkgs.zulu17;};
      prismlauncher = prev.prismlauncher.override {
        jdk21 = pkgs.zulu21; # Actually, it's useless, because Prismlauncher doesn't really need java.
        jdk17 = null; # Strip
        jdk8 = null; # Strip
        jdks = [pkgs.zulu21]; # Add JAVA_PATH for Prismlauncher
      };
    })
  ];
}
