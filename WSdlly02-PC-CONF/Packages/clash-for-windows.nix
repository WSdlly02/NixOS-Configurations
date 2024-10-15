{
  alsa-lib,
  autoPatchelfHook,
  at-spi2-core,
  dpkg,
  gtk3,
  iproute2,
  lib,
  libdrm,
  libGL,
  libpulseaudio,
  makeShellWrapper,
  mesa,
  nftables,
  nss,
  stdenv,
  fetchurl,
  wrapGAppsHook3,
  xorg,
}:
stdenv.mkDerivation {
  pname = "clash-for-windows";
  version = "0.20.39";
  src = fetchurl {
    url = https://github.com/lantongxue/clash_for_windows_pkg/releases/download/0.20.39/Clash.for.Windows-0.20.39-x64-linux.deb;
    sha256 = "sha256-8+ZFx45UUR2XvJkiHgNBHJ1/baw9sRNPWXRimDoQbjo=";
  };
  unpackPhase = ''
    runHook preUnpack
    dpkg -x $src ./
    runHook postUnpack
  '';
  nativeBuildInputs = [
    autoPatchelfHook
    makeShellWrapper
    wrapGAppsHook3
    dpkg
  ];
  buildInputs = [
    alsa-lib
    at-spi2-core
    gtk3
    libdrm
    libpulseaudio
    mesa
    nss
    xorg.libXdamage
    xorg.libXScrnSaver
  ];
  runtimeDependencies = map lib.getLib [
    xorg.libXScrnSaver
    libGL
    mesa
    nss
    libdrm
    iproute2
    nftables
  ];

  dontWrapGApps = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r opt $out/opt
    cp -r usr/share $out/share
    substituteInPlace $out/share/applications/clash-for-windows.desktop \
      --replace-quiet "/opt/clash_for_windows/cfw" "$out/bin/cfw"
    makeShellWrapper $out/opt/clash_for_windows/cfw $out/bin/cfw \
      --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libGL gtk3 mesa nss libdrm]}" \
      "''${gappsWrapperArgs[@]}"
    runHook postInstall
  '';
  meta = with lib; {
    homepage = "https://github.com/lantongxue/clash_for_windows_pkg";
    description = "A Windows/macOS/Linux GUI based on Clash";
    platforms = ["x86_64-linux"];
    license = licenses.unfree;
    sourceProvenance = with sourceTypes; [binaryNativeCode];
    maintainers = [];
  };
}
