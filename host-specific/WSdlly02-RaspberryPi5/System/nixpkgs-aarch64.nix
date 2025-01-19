{
  config,
  lib,
  ...
}: {
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
      (self: super: {
        linux_rpi5 = super.linux_rpi4.override {
          stdenv = super.ccacheStdenv;
          rpiVersion = 5;
          argsOverride.defconfig = "bcm2712_defconfig";
        };
      })
      (self: super: {
        ccacheWrapper = super.ccacheWrapper.override {
          extraConfig = ''
            export CCACHE_COMPRESS=1
            export CCACHE_DIR="${config.programs.ccache.cacheDir}"
            export CCACHE_UMASK=007
            if [ ! -d "$CCACHE_DIR" ]; then
              echo "====="
              echo "Directory '$CCACHE_DIR' does not exist"
              echo "Please create it with:"
              echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
              echo "  sudo chown root:nixbld '$CCACHE_DIR'"
              echo "====="
              exit 1
            fi
            if [ ! -w "$CCACHE_DIR" ]; then
              echo "====="
              echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
              echo "Please verify its access permissions"
              echo "====="
              exit 1
            fi
          '';
        };
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
