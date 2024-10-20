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
    # appimage.enable = true;
  };
  # services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      alejandra
      bilibili
      chromium
      clash-nyanpasu
      fastfetch
      fsearch
      gapless
      id-generator
      kdePackages.filelight
      kdePackages.sddm-kcm
      microsoft-edge
      mission-center
      motrix
      mpv
      obs-studio
      pass-wayland
      qbittorrent
      qq
      telegram-desktop
      thunderbird
      vlc
      vscode
      wechat-uos
      wpsoffice-cn
      yakuake
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
