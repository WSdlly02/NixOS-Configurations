{lib, ...}: {
  nix = {
    settings = {
      max-jobs = 64;
      substituters = lib.mkForce [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      trusted-users = [
        "root"
        "wsdlly02"
      ];
      auto-optimise-store = true;
      experimental-features = lib.mkForce [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux"; # specific this option blocks nixpkgs.crossSystem
    # localSystem = null; # equals to nixpkgs.buildPlatform
    # buildPlatform = config.nixpkgs.hostPlatform;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      enableParallelBuilding = true;
      rocmSupport = true;
    };
  };
  /*
  nixpkgs.crossSystem = {
    # Target platform
    system = "aarch64-linux";
  };
  Specifies the platform for which NixOS should be built.
  Specify this only if it is different from nixpkgs.localSystem,
  the platform on which NixOS should be built.
  In other words, specify this to cross-compile NixOS.
  */
  boot.binfmt.emulatedSystems = [
    # use QEMU to emulate systems for compiling pkgs of different archs.
    "x86_64-windows"
    "aarch64-linux"
  ];
  system = {
    name = "WSdlly02-PC";
    # nixos.tag = [];
    stateVersion = "24.11";
  };
}
