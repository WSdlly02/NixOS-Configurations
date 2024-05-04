{ callPackages, lib, pkgs, ... }:

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
    nerdfonts
  ];
  # Programs
  programs = {
    firefox.enable = true;
    noisetorch.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
    appimage.enable = true;
  };
  services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    variables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1.25";
    };
    defaultPackages = with pkgs; [
      fastfetch
      steam-run
      python310
      konsole
      yakuake
      ark
      kate
      gwenview
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
      wechat-uos
      mission-center
      upscayl
      wpsoffice-cn
      blender-hip
      (callPackage ./gnome-network-displays.nix { })
    ];
  };
}