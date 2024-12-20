{pkgs, ...}: let
  usedRocmPackages = with pkgs.rocmPackages; [
    clr
    clr.icd
    # hipblas
    hip-common
    # rocblas
    rocm-runtime
    rocminfo
    rocm-smi
    # rocm-thunk
    rocm-comgr
    rocm-device-libs
  ];
in {
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "rocm-python312-env";
      targetPkgs = pkgs: (with pkgs;
        [
          # Common pkgs
          gcc
          glibc
          dbus
          fish
          libdrm
          udev
          python312
          zstd
        ]
        ++ usedRocmPackages);
      runScript = "fish";
    })
  ];
}
