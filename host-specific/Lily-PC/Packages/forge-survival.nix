{
  lib,
  pkgs,
  stdenv,
  fetchurl,
  zulu21,
}: let
  minecraftVersion = "1.20.1";
  forgeVersion = "47.3.0";
in
  stdenv.mkDerivation {
    pname = "forge-survival";
    version = minecraftVersion + "-" + forgeVersion;
    src = fetchurl {
      url = "https://maven.minecraftforge.net/net/minecraftforge/forge/${minecraftVersion}-${forgeVersion}/forge-${minecraftVersion}-${forgeVersion}-installer.jar";
      sha256 = "e2fb76d0ca74a5557ff54bf8aac68eb6b12b741a785246772df72ddeadc4cbf8";
    };

    preferLocalBuild = true;

    installPhase = ''
      mkdir -p $out/bin $out/lib/minecraft
      cp -v $src $out/lib/minecraft/forge-survival-installer.jar

      cat > $out/bin/forge-server << EOF
      #!/bin/bash
      exec ${pkgs.zulu21}/bin/java \$@ -jar $out/lib/minecraft/forge-survival-installer.jar nogui
      EOF

      chmod +x $out/bin/forge-server
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
