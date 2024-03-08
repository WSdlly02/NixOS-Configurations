{ lib, stdenv, fetchurl, jdk21, }:

stdenv.mkDerivation {
  pname = "minecraft-server-fabric";
  version = "1.20.2";

  src = fetchurl {
    url = "https://meta.fabricmc.net/v2/versions/loader/1.20.2/0.15.7/1.0.0/server/jar";
    sha1 = "856cfeedcc5f1ede7ff6e94dd1975cdbb63b4286";
  };

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/lib/minecraft
    cp -v $src $out/lib/minecraft/server.jar

    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jdk21}/bin/java \$@ -jar $out/lib/minecraft/server.jar nogui
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