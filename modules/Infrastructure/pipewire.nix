{
  config,
  lib,
  ...
}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    socketActivation = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") false;
    audio.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  systemd.user.services.wireplumber.wantedBy = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") ["default.target"];
}
