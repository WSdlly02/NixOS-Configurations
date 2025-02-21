/*
  pkgs.rust.packages.stable.rustc = pkgs.rustc
  pkgs.rustPlatform.buildRustPackage = pkgs.rust.packages.stable.rustPlatform.buildRustPackage
*/
{
  inputs,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      gcc
      gdb
      # Rust toolchains
      cargo
      clippy
      rustc
      rustfmt
      # Python 3.12
      inputs.my-codes.legacyPackages."${pkgs.system}".python312Env
      # inputs.my-codes.legacyPackages."${pkgs.system}".python312FHSEnv
      # Other pkgs
    ];
    variables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };
}
