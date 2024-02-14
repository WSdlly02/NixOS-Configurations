{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
    #extraPackages32 = with pkgs.pkgsi686Linux; [
    #  libva
		#  vaapiVdpau
    #  libvdpau
		#  libvdpau-va-gl
    #];
    setLdLibraryPath = true;
  };
}