{
  /*
    systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  */
  environment.variables = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
    VDPAU_DRIVER = "radeonsi";
  };
}
