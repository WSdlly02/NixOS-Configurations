{
  config,
  inputs,
  lib,
  ...
}:
{
  nix = {
    channel.enable = false;
    nixPath = [
      "home-manager=${inputs.home-manager}"
      "nixpkgs=${inputs.nixpkgs-unstable}"
      "my-codes=${inputs.my-codes}"
      "self=${inputs.self}"
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
          path = "${inputs.my-codes}";
          type = "path";
        };
      };
      "nixpkgs".to = {
        path = "${inputs.nixpkgs-unstable}";
        type = "path";
      };
      "self" = {
        from = {
          id = "self";
          type = "indirect";
        };
        to = {
          path = "${inputs.self}";
          type = "path";
        };
      };
    };
    settings = {
      accept-flake-config = true; # Experimental
      auto-optimise-store = true;
      auto-allocate-uids = true; # Experimental
      experimental-features = [
        "auto-allocate-uids"
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
  };
}
