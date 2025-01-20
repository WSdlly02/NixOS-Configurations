{
  config,
  lib,
  pkgs,
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
        "10-allow-headless" = {
          wireplumber.profiles = {
            main = {
              monitor.bluez.seat-monitoring = "disabled";
            };
          };
        };
        # https://wiki.archlinux.org/title/Bluetooth_headset#Disable_PulseAudio_auto_switching_headset_to_HSP/HFP
        "20-bluetooth-settings" = {
          wireplumber.settings = {
            bluetooth.autoswitch-to-headset-profile = false;
          };
          monitor.bluez.properties = {
            bluez5.roles = ["a2dp_sink" "a2dp_source"];
            bluez5.auto-connect = ["a2dp_sink" "a2dp_source"];
            # LDAC encoding quality
            # Available values: auto (Adaptive Bitrate, default)
            #                   hq   (High Quality, 990/909kbps)
            #                   sq   (Standard Quality, 660/606kbps)
            #                   mq   (Mobile use Quality, 330/303kbps)
            bluez5.a2dp.ldac.quality = "hq";
            # AAC variable bitrate mode
            # Available values: 0 (cbr, default), 1-5 (quality level)
            bluez5.a2dp.aac.bitratemode = 5;
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
      preStart = "${pkgs.networkmanager}/bin/nm-online -q"; # Fix up
      wantedBy = ["default.target"];
    };
    pipewire-pulse.wantedBy = ["default.target"];
    wireplumber.wantedBy = ["default.target"];
  };
}
