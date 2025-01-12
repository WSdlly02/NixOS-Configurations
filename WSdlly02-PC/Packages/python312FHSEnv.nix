/*
Notice:

python3 = python312; # which is defined in <nixpkgs/pkgs/top-level/all-packages.nix>
python3Packages = dontRecurseIntoAttrs python312Packages; # same as above
python312Packages = recurseIntoAttrs python312.pkgs; # same as above
some packages requires old python-modules will specific {python3 = python311;} in args

buildEnv = callPackage ./wrapper.nix {
  python = self;
  inherit (pythonPackages) requiredPythonModules;
};
withPackages = import ./with-packages.nix { inherit buildEnv pythonPackages; }; which is defined in <nixpkgs/pkgs/development/interpreters/python/passthrufun.nix>
pkgs = pythonPackages; # same as above

virtualenv = with python3Packages; toPythonApplication virtualenv; # virtualenv = python3Packages.virtualenv
"toPythonApplication" converts a Python library to an application, which is defined in <nixpkgs/pkgs/development/interpreters/python/python-packages-base.nix>

python3.buildEnv.override {
  extraLibs = [ python3Packages.pyramid ];
  ignoreCollisions = true;
}

is equals to

python3.withPackages (ps: with ps; [
  numpy
  requests
])
*/
{
  buildFHSEnv,
  cmake,
  gcc,
  glibc,
  dbus,
  fish,
  libdrm,
  ninja,
  ncurses,
  udev,
  zstd,
  python312,
  # numpy, # which is used in buildPythonPackages {propagatedBuildInputs=[];}
}: let
  usedPython312Packages = python312.withPackages (ps:
    with ps; [
      numpy
      pandas
      uv
      virtualenv
    ]);
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
      pkgs: [
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
        zstd
        usedPython312Packages
      ]
      # ++ usedRocmPackages
    );
    runScript = "fish";
  }
