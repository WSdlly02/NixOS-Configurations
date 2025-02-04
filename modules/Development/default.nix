{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Rust toolchain
    cargo
    rustc
    rustfmt
    inputs.my-codes.packages."${pkgs.system}".python312Env
    # inputs.my-codes.packages."${pkgs.system}".python312FHSEnv
    # Other pkgs
  ];
}
