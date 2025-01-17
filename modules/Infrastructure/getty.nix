{
  config,
  lib,
  ...
}: let
  systemTags = lib.concatMapStringsSep " " (x: x) config.system.nixos.tags;
in {
  services.getty = {
    greetingLine = ''
      ${config.system.name} (\m)
      ${config.system.nixos.distroName} ${systemTags} \r
      Date: \d \t
      Terminal: \l
    '';
    helpLine = lib.mkForce "";
    autologinUser = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") "wsdlly02";
    autologinOnce = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") true;
  };
}
