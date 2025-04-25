{
  pkgs,
  ...
}:
let
  wayland-enable = {
    commandLineArgs = "--ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime=true";
  };
in
{
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
      maple-mono.Normal-NF-CN-unhinted
    ];
    fontconfig = {
      allowBitmaps = false;
      useEmbeddedBitmaps = true;
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [ "Sarasa UI SC" ];
        sansSerif = [ "Sarasa UI SC" ];
        monospace = [ "Maple Mono Normal NF CN" ];
        emoji = [ "Maple Mono Normal NF CN" ];
      };
    };
  };
  # Programs
  programs = {
    # appimage.enable = true;
    kdeconnect.enable = true;
    noisetorch.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        #droidcam-obs
        obs-vkcapture
        input-overlay
      ];
    };
    partition-manager.enable = true;
    thunderbird = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
  services.power-profiles-daemon.enable = true;
  # services.flatpak.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages =
      with pkgs;
      [
        (bilibili.override wayland-enable)
        (google-chrome.override wayland-enable)
        (microsoft-edge.override wayland-enable)
        (obsidian.override wayland-enable)
        (qq.override wayland-enable)
        (vscode.override wayland-enable)
        ddcutil # Required to control the brightness
        fastfetch
        fsearch
        gapless
        helvum
        mihomo-party
        mpv
        ncdu
        ocs-desktop
        pass-wayland
        qbittorrent-enhanced
        qcm
        scrcpy
        sunshine
        telegram-desktop
        vlc
        wechat-uos
        wemeet
        wpsoffice-cn
      ]
      ++ [
        kdePackages.sddm-kcm
        kdePackages.wallpaper-engine-plugin
        kdePackages.yakuake
      ];
  };
  /*
    nixpkgs.overlays = [
      # Notice: This overlay is deprecated due to some incompatible changes
      (final: prev: {
        mihomo-party = prev.mihomo-party.overrideAttrs (
          finalAttrs: previousAttrs: {
            # preFixup = previousAttrs.preFixup + "--add-flags ...";
            preFixup =
              if previousAttrs.version == "1.7.1" then
                ''
                  mkdir $out/bin
                  makeWrapper $out/mihomo-party/mihomo-party $out/bin/mihomo-party \
                    --prefix LD_LIBRARY_PATH : "${
                      lib.makeLibraryPath [
                        pkgs.libGL
                      ]
                    }" \
                  --add-flags "${wayland-enable.commandLineArgs}"
                ''
              else
                throw "The overlays' version is inconsistent with the current's ! Please update overlays."; # Add wayland support
          }
        );
      })
    ];
  */
}
