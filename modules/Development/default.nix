{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.self.packages."${pkgs.system}".python312Env
    # inputs.self.packages."${pkgs.system}".python312FHSEnv
    # Other pkgs
  ];
}
