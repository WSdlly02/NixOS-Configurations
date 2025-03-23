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
      inputs.my-codes.legacyPackages."${system}".haskellEnv # Haskell
      # Rust toolchains
      cargo
      clippy
      rustc
      rustfmt
      inputs.my-codes.legacyPackages."${system}".python312Env # Python 3.12
      # inputs.my-codes.legacyPackages."${system}".python312FHSEnv
      # Other pkgs
    ];
    variables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };
}
