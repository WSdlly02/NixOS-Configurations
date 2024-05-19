{ lib, stdenv, fetchurl, rpmextract, autoreconfHook, file, libjpeg, cups }:

let
  version = "1.0.0";
in
  stdenv.mkDerivation {

    pname = "epson_201601w";
    inherit version;

    src = fetchurl {
      urls = [
        "https://download3.ebz.epson.net/dsc/f/03/00/05/62/39/9f21bf22f723fc15a9c584687cc852b3a611f455/epson-inkjet-printer-201601w-1.0.0-1lsb3.2.src.rpm"
      ];
      sha256 = "a56f9da8557ed826d3a122961cee3c95c32f42c73c273ff01442fed9ce416241";
    };

    nativeBuildInputs = [ rpmextract autoreconfHook file ];

    buildInputs = [ libjpeg cups ];

    unpackPhase = ''
      rpmextract $src
      tar -zxf epson-inkjet-printer-201601w-${version}.tar.gz
      tar -zxf epson-inkjet-printer-filter-${version}.tar.gz
      for ppd in epson-inkjet-printer-201601w-${version}/ppds/*; do
        substituteInPlace $ppd --replace "/opt/epson-inkjet-printer-201601w" "$out"
        substituteInPlace $ppd --replace "/cups/lib" "/lib/cups"
      done
      cd epson-inkjet-printer-filter-${version}
    '';

    preConfigure = ''
      chmod +x configure
      export LDFLAGS="$LDFLAGS -Wl,--no-as-needed"
    '';

    postInstall = ''
      cd ../epson-inkjet-printer-201601w-${version}
      cp -a lib64 resource watermark $out
      mkdir -p $out/share/cups/model/epson-inkjet-printer-201601w
      cp -a ppds $out/share/cups/model/epson-inkjet-printer-201601w/
      cp -a Manual.txt $out/doc/
      cp -a README $out/doc/README.driver
    '';

    meta = with lib; {
      homepage = "https://www.openprinting.org/driver/epson-201601w";
      description = "Epson printer driver (L380)";
      longDescription = ''
        This software is a filter program used with the Common UNIX Printing
        System (CUPS) under Linux. It supplies high quality printing with
        Seiko Epson Color Ink Jet Printers.

        List of printers supported by this package:
           Epson L380 Series

        To use the driver adjust your configuration.nix file:
          services.printing = {
            enable = true;
            drivers = [ pkgs.epson_201601w ];
          };
      '';
      license = with licenses; [ lgpl21 epson ];
      maintainers = [ maintainers.romildo ];
      platforms = [ "x86_64-linux" ];
    };

  }