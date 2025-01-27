{ lib, ... }:
{
  services.syncthing = {
    enable = true;
    guiAddress = "127.0.0.1:8384";
    overrideDevices = false;
    overrideFolders = false;
  };
  systemd.user.services.syncthing.Install.WantedBy = lib.mkForce [ ];
}
