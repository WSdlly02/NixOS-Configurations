{pkgs, ...}: {
  imports = [
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
      extraPackages = with pkgs; [
        gamescope
      ];
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
    (mindustry.override {jdk17 = zulu17;})
    (prismlauncher.override rec {
      jdk21 = zulu21; # Actually, it's useless, because Prismlauncher doesn't really need java.
      jdk17 = null; # Strip
      jdk8 = null; # Strip
      jdks = [jdk21]; # Add JAVA_PATH for Prismlauncher
      textToSpeechSupport = false;
    })
    mangohud
    mangojuice
    mcrcon
    protonup-qt
    # vkbasalt
    # vkbasalt-cli
  ];
}
