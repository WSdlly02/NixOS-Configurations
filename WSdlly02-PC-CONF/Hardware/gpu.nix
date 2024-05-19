{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    #extraPackages = with pkgs; [
    #  rocm-opencl-icd
    #  rocm-opencl-runtime
    #  rocmPackages.clr
    #  rocmPackages.clr.icd
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