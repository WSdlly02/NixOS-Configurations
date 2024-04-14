{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
    #extraPackages32 = with pkgs.pkgsi686Linux; [
    #  libva
		#  vaapiVdpau
    #  libvdpau
		#  libvdpau-va-gl
    #];
    setLdLibraryPath = true;
  };
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
    VDPAU_DRIVER = "radeonsi";
  };
}