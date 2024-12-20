{
  lib,
  pkgs,
  stdenv,
  fetchurl,
  zulu21,
}: let
  minecraftVersion = "1.20.1";
  fabricVersion = "0.16.9";
in
  stdenv.mkDerivation {
    pname = "fabric-survival";
    version = minecraftVersion + "-" + fabricVersion;
    src = fetchurl {
      url = "https://meta.fabricmc.net/v2/versions/loader/${minecraftVersion}/${fabricVersion}/1.0.1/server/jar";
      sha256 = "e2fb76d0ca74a5557ff54bf8aac68eb6b12b741a785246772df72ddeadc4cbf8";
    };

    preferLocalBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/minecraft
      cp -v $src $out/lib/minecraft/fabric-survival.jar

      cat > $out/bin/minecraft-server << EOF
      #!/bin/bash
      exec ${pkgs.zulu21}/bin/java \$@ -jar $out/lib/minecraft/fabric-survival.jar nogui
      EOF

      chmod +x $out/bin/minecraft-server
    '';

    dontUnpack = true;

    meta = with lib; {
      description = "Minecraft Server with Fabric";
      homepage = "https://minecraft.net";
      sourceProvenance = with sourceTypes; [binaryBytecode];
      license = licenses.unfreeRedistributable;
      platforms = platforms.unix;
      maintainers = with maintainers; [thoughtpolice tomberek costrouc joelkoen];
    };
  }
