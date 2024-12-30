{lib, ...}: {
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    ethernet.macAddress = "stable";
    wifi.macAddress = "stable-ssid";
    plugins = lib.mkForce [];
    # rc-manager has been set as unmanaged
  };
}
