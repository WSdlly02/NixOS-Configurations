{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./nixpkgs-aarch64.nix
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["vfat" "btrfs"];
      availableKernelModules = [];
      # verbose = false;
      kernelModules = [];
      systemd.enable = true; # Hibernate Required
    };
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = lib.mkForce false;
    # consoleLogLevel = 3;
    /*
    kernelPackages = pkgs.linuxKernel.packagesFor (pkgs.linuxKernel.kernels.linux_rpi4.override {
      rpiVersion = 5;
      argsOverride.defconfig = "bcm2712_defconfig";
    });
    # Already defined in the nixos-hardware.nixosModules.raspberry-pi-5
    */
    kernelParams = [
      # "quiet"
      "nowatchdog"
      # "udev.log_level=3"
      "8250.nr_uarts=11"
      "console=ttyAMA10,9600"
      "console=tty0"
    ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@home"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@nix"];
    };

    "/var/cache" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-cache"];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-log"];
    };

    "/var/tmp" = {
      device = "/dev/disk/by-uuid/2d53c0bf-e6c5-4ce5-af12-472c04d1b827";
      fsType = "btrfs";
      options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-tmp"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = ["rw" "relatime" "fmask=0077" "dmask=0077" "codepage=437" "iocharset=iso8859-1" "shortname=mixed" "errors=remount-ro"];
    };
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/e991f2a1-fd30-48f1-a99b-527220618083";
      discardPolicy = "pages";
    }
  ];
  hardware = {
    enableRedistributableFirmware = true;
    # enableAllHardware = true;
    # enableAllFirmware = true;
    firmwareCompression = "zstd";
  };
}
