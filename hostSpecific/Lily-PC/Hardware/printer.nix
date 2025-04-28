{
  hardware.printers = {
    ensurePrinters = [
      {
        name = "EPSON_L380_Series";
        location = "Home";
        deviceUri = "usb://EPSON/L380%20Series?serial=583251373133313214&interface=1";
        model = "epson-inkjet-printer-201601w/ppds/EPSON_L380.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "EPSON_L380_Series";
  };
}
