{
  config,
  ...
}:
{
  nix = {
    settings = {
      accept-flake-config = true; # Experimental
      auto-optimise-store = true;
      auto-allocate-uids = true; # Experimental
      download-buffer-size = 134217728; # 128MB
      fsync-metadata = false;
      http-connections = 64;
      max-jobs = if (config.system.name == "WSdlly02-PC") then 64 else 32;
      substituters = [
        "https://cache.nixos.org"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      trusted-users = [
        "wsdlly02"
      ];
      pure-eval = true;
      experimental-features = [
        "auto-allocate-uids"
        "flakes"
        "nix-command"
      ];
      extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
    };
  };
}
