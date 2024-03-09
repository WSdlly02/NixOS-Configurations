{ config, pkgs, ... }:

{ 
  users.users.wsdlly02 = {
    isNormalUser = true;
    group = "wheel";
    extraGroups = [ "users" "adbusers" ];
  };
  nixpkgs.config.allowUnfree = true;
  # Fonts
  fonts.packages = with pkgs; [
    sarasa-gothic
  ];
  # Programs
  programs = {
    firefox.enable = true;
    noisetorch.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
  };
  environment = {
    localBinInPath = true;
    ##variables = 
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
      lact
      kdePackages.sddm-kcm
      kdePackages.filelight
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
      wpsoffice-cn
      blender-hip
    ];
  };
}
