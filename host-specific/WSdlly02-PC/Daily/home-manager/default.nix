{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.wsdlly02 = import ./wsdlly02.nix;
    extraSpecialArgs = { inherit inputs; };
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
