{
  config,
  inputs,
  ...
}:
{
  nix = {
    channel.enable = false;
    registry = {
      "my-codes" = {
        from = {
          id = "my-codes";
          type = "indirect";
        };
        to = {
          path = inputs.my-codes;
          type = "path";
        };
      };
      "nixpkgs".to = {
        path = inputs.nixpkgs-unstable;
        type = "path";
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
      extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
      fsync-metadata = false;
      http-connections = 64;
      max-jobs = if (config.system.name == "WSdlly02-PC") then 64 else 32;
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      trusted-users = [
        "wsdlly02"
      ];
      pure-eval = true;
    };
  };
}
