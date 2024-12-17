{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "rocm-python312-env";
      targetPkgs = pkgs: (with pkgs; [
        udev
        gcc
        dbus
        fish
        libdrm
        python312
        zstd
        /*
        (with rocmPackages; [
          rocm-core
          clr
          rccl
          miopen # Compiling failed
          rocrand
          rocblas
          rocsparse
          hipsparse
          rocthrust
          rocprim
          hipcub
          roctracer
          rocfft
          rocsolver
          hipfft
          hipsolver
          hipblas
          rocminfo
          rocm-thunk
          rocm-comgr
          rocm-device-libs
          rocm-runtime
          clr.icd
          hipify
        ])
        */
      ]);
      runScript = "fish";
    })
  ];
}
