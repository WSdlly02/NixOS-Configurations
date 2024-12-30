/*
hardware.amdgpu.opencl.enable and nixpkgs.config.rocmSupport is diabled
*/
{pkgs, ...}: let
  usedPython312Packages = with pkgs.python312Packages; [
    virtualenv
  ];
  /*
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
  */
in {
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "python312FHSEnv";
      targetPkgs = pkgs: (
        with pkgs;
          [
            # Common pkgs
            cmake
            gcc
            glibc
            dbus
            fish
            libdrm
            ninja
            ncurses
            udev
            uv
            python312
            zstd
          ]
          ++ usedPython312Packages
        # ++ usedRocmPackages
      );
      runScript = "fish";
    })
    # Other pkgs
  ];
}
