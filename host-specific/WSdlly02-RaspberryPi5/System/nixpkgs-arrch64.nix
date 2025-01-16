{lib, ...}: {
  nix = {
    settings = {
      max-jobs = 32;
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
    };
  };
  nixpkgs = {
    hostPlatform = lib.mkDefault "aarch64-linux"; # specific this option blocks nixpkgs.crossSystem
    # localSystem = null; # equals to nixpkgs.buildPlatform
    # buildPlatform = config.nixpkgs.hostPlatform;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      enableParallelBuilding = true;
    };
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // {allowMissing = true;});
      })
    ];
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
  system = {
    name = "WSdlly02-RaspberryPi5";
    # nixos.tag = [];
    stateVersion = "25.05";
  };
}
