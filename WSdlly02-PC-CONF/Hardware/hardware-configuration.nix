# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
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
      kernelModules = [];
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["amdgpu" "kvm-amd"];
    extraModulePackages = [];
    kernelParams = ["quiet" "loglevel=3"];
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
  # networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    enableRedistributableFirmware = true;
    amdgpu.initrd.enable = true;
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    xone.enable = true;
  };
}
