{
  pkgs,
  cmake,
  gcc,
  glibc,
  dbus,
  fish,
  libdrm,
  ninja,
  ncurses,
  udev,
  uv,
  virtualenv,
  python312,
  zstd,
  buildFHSEnv,
}: let
  usedPython312Packages = [
    virtualenv
  ];
  /*
  usedRocmPackages = [
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
in
  buildFHSEnv {
    name = "python312FHSEnv";
    targetPkgs = (
      pkgs:
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
  }
