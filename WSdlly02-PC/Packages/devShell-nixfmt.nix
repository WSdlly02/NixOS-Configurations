{mkShell}:
mkShell {
  buildInputs = with pkgs; [
    nixpkgs-fmt
  ];
  shellHook = ''
    fish
  '';
}
