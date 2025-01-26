{
  pkgs,
  lib,
  ...
}: let
  wayland-enable = {commandLineArgs = "--ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime=true";};
in {
  imports = [
    ./home-manager
    ./fcitx5.nix
    ./lact.nix
    ./plasma6.nix
    ./sunshine.nix
    ##./wine.nix
  ];
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
        emoji = ["Noto Color Emoji"];
      };
    };
  };
  # Programs
  programs = {
    firefox.enable = true;
    noisetorch.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    kdeconnect.enable = true;
    partition-manager.enable = true;
    # appimage.enable = true;
  };
  services.power-profiles-daemon.enable = true;
  # services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs;
      [
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
        # id-generator is in home-manager
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
      ]
      ++ [
        kdePackages.sddm-kcm
        kdePackages.yakuake
      ];
  };
  nixpkgs.overlays = [
    (final: prev: {
      profile-sync-daemon = prev.profile-sync-daemon.overrideAttrs (finalAttrs: previousAttrs: {
        installPhase = previousAttrs.installPhase + "cp $out/share/psd/contrib/microsoft-edge $out/share/psd/browsers"; # Add microsoft-edge support
      });
    })
    (final: prev: {
      mihomo-party = prev.mihomo-party.overrideAttrs (finalAttrs: previousAttrs: {
        # preFixup = previousAttrs.preFixup + "--add-flags ...";
        preFixup =
          if prev.mihomo-party.version == "1.5.12"
          then ''
            mkdir $out/bin
            makeWrapper $out/mihomo-party/mihomo-party $out/bin/mihomo-party \
              --prefix LD_LIBRARY_PATH : "${
              lib.makeLibraryPath [
                pkgs.libGL
              ]
            }" \
            --add-flags "--ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime=true"
          ''
          else throw "The overlays' version is inconsistent with the current's ! Please update overlays."; # Add wayland support
      });
    })
    /*
    (final: prev: {foo=bar;})
    */
  ];
}
