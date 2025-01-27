{
  lib,
  stdenv,
  fetchurl,
  zulu21,
}:
let
  minecraftVersion = "1.20.1";
  fabricVersion = "0.16.9";
in
stdenv.mkDerivation {
  pname = "fabric-survival";
  version = minecraftVersion + "-" + fabricVersion;
  src = fetchurl {
    url = "https://meta.fabricmc.net/v2/versions/loader/${minecraftVersion}/${fabricVersion}/1.0.1/server/jar";
    sha256 = "sha256-QreRti11yhe31QIBUGn9iv2mgkwUFKq0uf16MlGl/z0=";
  };

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/lib/minecraft
    cp -v $src $out/lib/minecraft/fabric-survival.jar

    cat > $out/bin/fabric-server << EOF
    #!/bin/bash
    exec ${zulu21}/bin/java \$@ -jar $out/lib/minecraft/fabric-survival.jar nogui
    EOF

    chmod +x $out/bin/fabric-server
  '';

  dontUnpack = true;

  meta = with lib; {
    description = "Minecraft Server with Fabric";
    homepage = "https://minecraft.net";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    maintainers = with maintainers; [
      thoughtpolice
      tomberek
      costrouc
      joelkoen
    ];
  };
}
