{lib, ...}: {
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
      # Very important!!! Don't delete!!!
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // {allowMissing = true;});
      })
      /*
      (self: super: {
        linux_rpi5 = super.linux_rpi4.override {
          rpiVersion = 5;
          argsOverride.defconfig = "bcm2712_defconfig";
        };
      })
      */
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
