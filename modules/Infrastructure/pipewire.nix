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
    wireplumber = {
      enable = true;
      extraConfig = {
        "mitigate-annoying-profile-switch" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
          "monitor.bluez.properties" = {
            "bluez5.roles" = ["a2dp_sink" "a2dp_source"];
          };
        };
      };
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  systemd.user.services = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") {
    pipewire = {
      wantedBy = ["default.target"];
      wants = ["NetworkManager-wait-online.service"];
      after = ["NetworkManager-wait-online.service"];
    };
    pipewire-pulse.wantedBy = ["default.target"];
    wireplumber.wantedBy = ["default.target"];
  };
}
