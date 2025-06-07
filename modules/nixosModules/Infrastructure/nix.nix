{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  defaultUsername = config.hostSystemSpecific.defaultUser.name;
in
{
  nix = {
    channel.enable = false;
    nixPath = [
      "home-manager=${inputs.home-manager}"
      "my-codes=/home/${defaultUsername}/Documents/my-codes"
      "nix-config=/home/${defaultUsername}/Documents/nix-config"
      "nixpkgs=${pkgs.self.outPath}"
    ];
    registry = {
      "home-manager" = {
        from = {
          id = "home-manager";
          type = "indirect";
        };
        to = {
          path = "${inputs.home-manager}";
          type = "path";
        };
      };
      "my-codes" = {
        from = {
          id = "my-codes";
          type = "indirect";
        };
        to = {
          path = "/home/${defaultUsername}/Documents/my-codes";
          type = "path";
        };
      };
      "nix-config" = {
        from = {
          id = "nix-config";
          type = "indirect";
        };
        to = {
          path = "/home/${defaultUsername}/Documents/nix-config";
          type = "path";
        };
      };
      "nixpkgs".to = {
        path = "${pkgs.self.outPath}";
        type = "path";
      };
    };
    settings = {
      accept-flake-config = true; # Experimental
      auto-optimise-store = true;
      auto-allocate-uids = true; # Experimental
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "flakes"
        "nix-command"
      ];
      extra-sandbox-paths = lib.optionals config.programs.ccache.enable [
        config.programs.ccache.cacheDir
      ];
      fsync-metadata = false;
      http-connections = 0;
      max-jobs = config.hostSystemSpecific.nix.settings.max-jobs;
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      trusted-users = [
        "wsdlly02"
      ];
    };
    package = pkgs.lixPackageSets.latest.lix;
  };
}
