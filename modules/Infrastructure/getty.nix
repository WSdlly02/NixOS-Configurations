{
  config,
  lib,
  ...
}:
let
  systemTags = lib.concatMapStringsSep " " (x: x) config.system.nixos.tags;
in
{
  services.getty = {
    greetingLine = ''
      ${config.system.name} (\m)
      ${config.system.nixos.distroName} ${systemTags} \r
      Date: \d \t
      Terminal: \l
    '';
    helpLine = lib.mkForce "";
  };
}
