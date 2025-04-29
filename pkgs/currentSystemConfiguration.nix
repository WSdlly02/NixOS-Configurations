{ inputs, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "currentSystemConfiguration";
  version = inputs.self.lastModifiedDate;
  src = inputs.self;
  preferLocalBuild = true;
  allowSubstitutes = false;
  installPhase = ''
    mkdir -p $out/share/currentSystemConfiguration
    cp -r $src/* $out/share/currentSystemConfiguration
  '';
}
