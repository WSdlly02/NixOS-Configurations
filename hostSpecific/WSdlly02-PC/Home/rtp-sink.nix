{
  xdg.configFile."pipewire/pipewire.conf.d/20-rtp-sink.conf" = {
    text = ''
      context.modules = [
      {   name = libpipewire-module-rtp-sink
          args = {
              local.ifname = "wlp15s0"
              destination.ip = "10.42.0.2"
              destination.port = 10001
              sess.min-ptime = 2
              sess.max-ptime = 20
              sess.name = "PipeWire RTP stream"
              sess.media = "audio"
              audio.format = "S16BE"
              audio.rate = 48000
              audio.channels = 2
              audio.position = [ FL FR ]
              stream.props = {
                  node.name = "rtp-sink"
              }
          }
      }
      ]
    '';
  };
}
