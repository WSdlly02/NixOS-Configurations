/*
  pkgs.rust.packages.stable.rustc = pkgs.rustc
  pkgs.rustPlatform.buildRustPackage = pkgs.rust.packages.stable.rustPlatform.buildRustPackage
*/
{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      cloc # counts blank lines, comment lines, and physical lines of source code
      gcc
      gdb
      haskellEnv # Haskell
      # Rust toolchains
      cargo
      clippy
      rustc
      rustfmt
      python312Env # Python 3.12
      # python312FHSEnv
      # Other pkgs
    ];
    variables = {
      RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
    };
  };
}
