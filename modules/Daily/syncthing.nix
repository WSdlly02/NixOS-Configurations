{config, ...}: {
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress =
      if config.system.name != "WSdlly02-PC"
      then "0.0.0.0:8384"
      else "127.0.0.1:8384";
    systemService = false;
  };
}
