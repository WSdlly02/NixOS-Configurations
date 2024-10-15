{
  pkgs,
  inputs,
  ...
}: {
  users.users.wsdlly02 = {
    isNormalUser = true;
    uid = 1000;
    group = "wheel";
    extraGroups = ["users" "adbusers"];
  };
  nixpkgs.config.allowUnfree = true;
  # Fonts
  fonts.packages = with pkgs; [
    sarasa-gothic
    noto-fonts-color-emoji
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
    defaultPackages = with pkgs; [
      fastfetch
      python310
      lact
      yakuake
      kdePackages.sddm-kcm
      kdePackages.filelight
      thunderbird
      microsoft-edge
      chromium
      g4music
      motrix
      vulkan-tools
      fsearch
      qbittorrent
      bilibili
      vscode
      alejandra
      obs-studio
      vlc
      mpv
      qq
      wechat-uos
      telegram-desktop
      mission-center
      upscayl
      wpsoffice-cn
      clash-nyanpasu
      id-generator
      pass-wayland
    ];
  };
  nixpkgs.overlays = [
    (self: super: {
      id-generator = pkgs.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> ~/Documents/id-list.txt
        echo $sha512ID >> ~/Documents/id-list.txt
        echo $sha512ID
      '';
    })
  ];
}
