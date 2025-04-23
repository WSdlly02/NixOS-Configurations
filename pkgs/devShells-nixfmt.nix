{
  mkShell,
  nixfmt-rfc-style,
}:
mkShell {
  buildInputs = [
    nixfmt-rfc-style
  ];
  shellHook = ''
    fish
  '';
}
