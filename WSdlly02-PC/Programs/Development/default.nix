{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (buildFHSEnv {
      name = "rocm-python312-env";
      targetPkgs = pkgs: (with pkgs; [
        gcc
        glibc
        dbus
        fish
        libdrm
        udev
        python312
        zstd
        rocmPackages.clr
        rocmPackages.clr.icd
        # rocmPackages.hipblas
        # rocmPackages.rocblas
        rocmPackages.rocm-runtime
        rocmPackages.rocminfo
        rocmPackages.rocm-smi
      ]);
      runScript = "fish";
    })
  ];
}
