{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = [
    nixpkgs-fmt
  ];
  shellHook = ''
    fish
  '';
}
