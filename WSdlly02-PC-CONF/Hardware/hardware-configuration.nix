{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      supportedFilesystems = ["btrfs"];
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
      verbose = false;
      kernelModules = [];
    };
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["kvm-amd"];
    /*
    extraModulePackages = with pkgs; [
      config.boot.kernelPackages.zenpower
    ];
    */
    kernelParams = ["quiet" "udev.log_level=3" "amd_iommu=pt" "amdgpu.ppfeaturemask=0xffffffff"];
    # blacklistedKernelModules = ["k10temp"];
    # resumeDevice = "";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "space_cache=v2" "subvol=@"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "space_cache=v2" "subvol=@home"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/9c058d11-63b8-4a19-8884-28519aaa8b16";
    fsType = "btrfs";
    options = ["rw" "relatime" "ssd" "space_cache=v2" "subvol=@nix"];
  };

  fileSystems."/efi" = {
    device = "/dev/disk/by-uuid/18B2-C53C";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    enableRedistributableFirmware = true;
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    xone.enable = true;
  };
}
