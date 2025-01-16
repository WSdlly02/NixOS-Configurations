{
  mkShell,
  nixpkgs-fmt,
  fish,
}:
mkShell {
  buildInputs = [
    nixpkgs-fmt
  ];
  shellHook = ''
    fish
  '';
}
