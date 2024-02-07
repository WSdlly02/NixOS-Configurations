{ pkgs, stdenv, lib, buildLinux, fetchFromGitHub, ... }:

{
  boot.kernelPackages = let
    linux_xanmod_edge_pkg = { fetchFromGitHub, buildLinux, ... } @ args:
      buildLinux (args // rec {
        version = "6.7.3";
        modDirVersion = version;
        src = fetchFromGitHub {
          owner = "xanmod";
          repo = "linux";
          rev = modDirVersion;
          hash = "";
        };
      kernelPatches = [];
      extraConfig = ''
        INTEL_SGX y
      '';
      extraMeta.branch = "6.7";
      } // (args.argsOverride or {}));
    linux_xanmod_edge = pkgs.callPackage linux_xanmod_edge_pkg{};
  in 
    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_xanmod_edge);
}