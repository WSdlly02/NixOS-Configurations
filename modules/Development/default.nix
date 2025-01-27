# hardware.amdgpu.opencl.enable is diabled
{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.self.packages.${pkgs.system}.python312FHSEnv
    # Other pkgs
  ];
}
