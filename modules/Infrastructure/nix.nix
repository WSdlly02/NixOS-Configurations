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
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
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
