{
  mkShell,
  nixfmt-rfc-style,
  fish,
}:
mkShell {
  buildInputs = [
    nixfmt-rfc-style
  ];
  shellHook = ''
    fish
  '';
}
