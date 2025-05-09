{
  config,
  lib,
  enableInfrastructure,
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      ethernet.macAddress = "stable";
      wifi = {
        macAddress = "stable-ssid";
        powersave = lib.mkIf (config.system.name != "WSdlly02-PC") false;
      };
      plugins = lib.mkForce [ ];
      # rc-manager has been set as unmanaged
    };
  };
}
