{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./bluetooth.nix
    # ./bootloader.nix
    ./gpu.nix
    ./localdisksmount.nix
    ##./printer.nix
    ##./remotefsmount.nix
    ./tpm.nix
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["btrfs"];
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      verbose = false;
      kernelModules = [];
      systemd.enable = true; # Hibernate Required
    };
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["kvm-amd"];
    extraModulePackages = with pkgs; [
      linuxKernel.packages.linux_xanmod_latest.zenergy
    ];
    kernelParams = [
      "quiet"
      "nowatchdog"
      "udev.log_level=3"
      "amd_iommu=pt"
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    # blacklistedKernelModules = ["k10temp"];
    tmp = {
      useTmpfs = true;
      tmpfsSize = "100%";
      cleanOnBoot = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@home"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@nix"];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-cache"];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-log"];
  };

  fileSystems."/var/tmp" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@var-tmp"];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "discard=async" "space_cache=v2" "subvol=@swap"];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/18B2-C53C";
    fsType = "vfat";
    options = ["rw" "relatime" "fmask=0022" "dmask=0022" "codepage=437" "iocharset=ascii" "shortname=mixed" "errors=remount-ro"];
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      discardPolicy = "pages";
    }
  ];
  hardware = {
    enableRedistributableFirmware = true;
    # enableAllHardware = true;
    # enableAllFirmware = true;
    firmwareCompression = "zstd";
    cpu.amd = {
      ryzen-smu.enable = true;
      updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
    i2c.enable = true;
    xone.enable = true;
  };
}
