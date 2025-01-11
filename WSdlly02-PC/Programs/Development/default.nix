/*
hardware.amdgpu.opencl.enable is diabled
*/
{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    inputs.self.packages."x86_64-linux".python312FHSEnv
    # Other pkgs
  ];
}
