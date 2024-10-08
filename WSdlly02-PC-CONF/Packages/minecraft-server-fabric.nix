{ pkgs, callPackages, lib, stdenv, fetchurl, zulu, }:

stdenv.mkDerivation {
  pname = "minecraft-server-fabric";
  version = "1.20.1";
  src = fetchurl {
    url = "https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.10/1.0.1/server/jar";
    sha256 = "e2fb76d0ca74a5557ff54bf8aac68eb6b12b741a785246772df72ddeadc4cbf8";
  };

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/lib/minecraft
    cp -v $src $out/lib/minecraft/server.jar

    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${zulu}/bin/java \$@ -jar $out/lib/minecraft/server.jar nogui
    EOF

    chmod +x $out/bin/minecraft-server
  '';

  dontUnpack = true;

  meta = with lib; {
    description = "Minecraft Server with Fabric";
    homepage = "https://minecraft.net";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    maintainers = with maintainers; [ thoughtpolice tomberek costrouc joelkoen ];
  };
}
