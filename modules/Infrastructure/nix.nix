{
  config,
  lib,
  ...
}:
{
  nix = {
    settings = {
      max-jobs = if (config.system.name == "WSdlly02-PC") then 64 else 32;
      substituters = lib.mkForce [
        "https://cache.nixos.org"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      trusted-users = [
        "wsdlly02"
      ];
      auto-optimise-store = true;
      experimental-features = lib.mkForce [
        "nix-command"
        "flakes"
      ];
      extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
    };
  };
}
