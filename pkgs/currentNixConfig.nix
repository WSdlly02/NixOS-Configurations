{ inputs, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "currentNixConfig";
  version = "${inputs.self.lastModifiedDate}";
  src = "${inputs.self}";
  dontFixup = true;
  allowSubstitutes = false;
  installPhase = ''
    mkdir -p $out/share/currentNixConfig
    cp -r $src/* $out/share/currentNixConfig
  '';
}
