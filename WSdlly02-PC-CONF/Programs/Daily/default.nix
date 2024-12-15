{pkgs, ...}: {
  imports = [
    ##./envfs.nix
    ./fcitx5.nix
    ./lact.nix
    ##./nur.nix
    ./plasma6.nix
    ./psd.nix
    ./sunshine.nix
    ./syncthing.nix
    ##./wine.nix
  ];
  users.users.wsdlly02 = {
    isNormalUser = true;
    uid = 1000;
    group = "wheel";
    extraGroups = ["users" "adbusers"];
  };
  nixpkgs.config.allowUnfree = true;
  # Fonts
  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      noto-fonts-color-emoji
    ];
    fontconfig = {
      allowBitmaps = false;
      useEmbeddedBitmaps = true;
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = ["Sarasa UI SC"];
        sansSerif = ["Sarasa UI SC"];
        monospace = ["Sarasa Fixed SC"];
      };
    };
  };
  # Programs
  programs = {
    firefox.enable = true;
    lazygit.enable = true;
    noisetorch.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    kdeconnect.enable = true;
    partition-manager.enable = true;
    # appimage.enable = true;
  };
  services = {
    power-profiles-daemon.enable = true;
  };
  # services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      alejandra
      bilibili
      ddcutil
      google-chrome
      fastfetch
      fsearch
      gapless
      go-musicfox
      id-generator
      kdePackages.filelight
      kdePackages.sddm-kcm
      microsoft-edge
      mihomo-party
      mpv
      ncdu
      helvum
      obsidian
      pass-wayland
      qbittorrent-enhanced
      qq
      telegram-desktop
      thunderbird
      scrcpy
      sunshine
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
