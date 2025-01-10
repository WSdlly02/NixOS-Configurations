{lib, ...}: {
  nix = {
    settings = {
      max-jobs = 64;
      substituters = lib.mkForce [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      auto-optimise-store = true;
      experimental-features = lib.mkForce [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      enableParallelBuilding = true;
      rocmSupport = true;
    };
  };
  boot.binfmt.emulatedSystems = [
    "x86_64-windows"
    "aarch64-linux"
  ];
  system = {
    name = "WSdlly02-PC";
    # nixos.tag = [];
    stateVersion = "24.11";
  };
}
