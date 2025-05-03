{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./psd.nix
    ./roc-sink.nix
    ./sh.nix
    ./syncthing.nix
  ];
  programs = {
    command-not-found = {
      enable = true;
      dbPath = "/nix/programs.sqlite";
    };
    home-manager.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      id-generator
      ocs-desktop
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
  nixpkgs.overlays = [
    (final: prev: {
      profile-sync-daemon = prev.profile-sync-daemon.overrideAttrs (
        finalAttrs: previousAttrs: {
          src = prev.fetchFromGitHub {
            owner = "graysky2";
            repo = "profile-sync-daemon";
            rev = "cd8c2a37f152bd2bde167a0e066085ac23bc17d9";
            hash = "sha256-+4VHOJryoNodJvx5Ug2TX7/T3OsFW5VwxaL9WUcp8xA=";
          };
          installPhase =
            previousAttrs.installPhase
            + ''
              cp $out/share/psd/contrib/microsoft-edge $out/share/psd/browsers
              cp $out/share/psd/contrib/vscode $out/share/psd/browsers
              cp $out/share/psd/contrib/zen $out/share/psd/browsers
            '';
        }
      );
    })
  ];
}
