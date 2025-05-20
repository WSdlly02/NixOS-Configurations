{
  config,
  lib,
  pkgs,
  enableInfrastructure,
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "10-allow-headless" = {
            "wireplumber.profiles" = {
              "main" = {
                "monitor.bluez.seat-monitoring" = "disabled";
              };
            };
          };
          # https://wiki.archlinux.org/title/Bluetooth_headset#Disable_PulseAudio_auto_switching_headset_to_HSP/HFP
          "20-bluetooth-settings" = {
            "wireplumber.settings" = {
              "bluetooth.autoswitch-to-headset-profile" = false;
            };
            "monitor.bluez.properties" = {
              "bluez5.roles" = [
                "a2dp_sink"
                "a2dp_source"
              ];
              "bluez5.auto-connect" = [
                "a2dp_sink"
                "a2dp_source"
              ];
              # LDAC encoding quality
              # Available values: auto (Adaptive Bitrate, default)
              #                   hq   (High Quality, 990/909kbps)
              #                   sq   (Standard Quality, 660/606kbps)
              #                   mq   (Mobile use Quality, 330/303kbps)
              "bluez5.a2dp.ldac.quality" = "hq";
              # AAC variable bitrate mode
              # Available values: 0 (cbr, default), 1-5 (quality level)
              "bluez5.a2dp.aac.bitratemode" = 5;
            };
          };
          /*
            # https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
            "50-disable-suspension" = {
              "monitor.alsa.rules" = [
                {
                  "matches" = [
                    {"node.name" = "~alsa_input.*";}
                    {"node.name" = "~alsa_output.*";}
                  ];
                  "actions" = {
                    "update-props" = {
                      "session.suspend-timeout-seconds" = 0;
                    };
                  };
                }
              ];
              # bluetooth devices
              "monitor.bluez.rules" = [
                {
                  "matches" = [
                    {"node.name" = "~bluez_input.*";}
                    {"node.name" = "~bluez_output.*";}
                  ];
                  "actions" = {
                    "update-props" = {
                      "session.suspend-timeout-seconds" = 0;
                    };
                  };
                }
              ];
            };
          */
        };
      };
      socketActivation = config.hostSystemSpecific.services.pipewire.socketActivation;
      extraConfig = {
        pipewire."92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
        pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = "32/48000";
                pulse.default.req = "32/48000";
                pulse.max.req = "32/48000";
                pulse.min.quantum = "32/48000";
                pulse.max.quantum = "32/48000";
              };
            }
          ];
          stream.properties = {
            node.latency = "32/48000";
            resample.quality = 1;
          };
        };
      };
    };
    systemd.user.services = lib.mkIf (config.system.name == "WSdlly02-RaspberryPi5") {
      pipewire = {
        preStart = "${pkgs.networkmanager}/bin/nm-online -q"; # Fix up
        wantedBy = [ "default.target" ];
      };
      pipewire-pulse.wantedBy = [ "default.target" ];
      wireplumber.wantedBy = [ "default.target" ];
    };
  };
}
