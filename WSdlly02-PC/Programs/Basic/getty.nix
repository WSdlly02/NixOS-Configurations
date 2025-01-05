{
  config,
  lib,
  ...
}: let
  systemTags = lib.concatMapStringsSep " " (x: x) config.system.nixos.tags;
in {
  services.getty = {
    greetingLine = ''WSdlly02-PC ${config.system.nixos.distroName} ${systemTags} \m - \l'';
    helpLine = lib.mkForce "";
  };
}
