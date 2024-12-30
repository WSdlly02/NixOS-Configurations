{
  pkgs,
  callPackages,
  lib,
  ...
}: let
  wayland-enable = {commandLineArgs = "--ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime=true";};
in {
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
    ##partition-manager.enable = true;
    # appimage.enable = true;
  };
  services = {
    power-profiles-daemon.enable = true;
  };
  # services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      (bilibili.override wayland-enable)
      (element-desktop.override wayland-enable)
      (google-chrome.override wayland-enable)
      (microsoft-edge.override wayland-enable)
      (obsidian.override wayland-enable)
      (qq.override wayland-enable)
      (vscode.override wayland-enable)
      alejandra
      ddcutil # Required to control the brightness
      fastfetch
      fsearch
      gapless
      helvum
      id-generator
      kdePackages.filelight
      kdePackages.sddm-kcm
      kdePackages.yakuake
      mihomo-party
      mpv
      ncdu
      pass-wayland
      qbittorrent-enhanced
      qcm
      scrcpy
      sunshine
      telegram-desktop
      thunderbird
      vlc
      wechat-uos
      wpsoffice-cn
    ];
  };
  nixpkgs.overlays = [
    (final: prev: {
      mihomo-party = prev.mihomo-party.overrideAttrs (finalAttrs: previousAttrs: {
        # preFixup = previousAttrs.preFixup + "--add-flags ...";
        preFixup = ''
          mkdir $out/bin
          makeWrapper $out/mihomo-party/mihomo-party $out/bin/mihomo-party \
            --prefix LD_LIBRARY_PATH : "${
            lib.makeLibraryPath [
              pkgs.libGL
            ]
          }" \
          --add-flags "--ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime=true"
        ''; # Add wayland support
      });
    })
    (self: super: {
      id-generator = pkgs.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> ~/Documents/id-list.txt
        echo $sha512ID >> ~/Documents/id-list.txt
        echo $sha512ID
      '';
    })
    /*
    (self: super: {foo=bar;})
    */
  ];
}
