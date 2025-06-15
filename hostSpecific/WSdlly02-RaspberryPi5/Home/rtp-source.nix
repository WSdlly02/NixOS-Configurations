{
  xdg.configFile."pipewire/pipewire.conf.d/20-rtp-source.conf" = {
    text = ''
      context.modules = [
      {   name = libpipewire-module-rtp-source
          args = {
              local.ifname = end0
              source.ip = 10.42.0.1
              source.port = 10001
              sess.latency.msec = 40
              sess.ignore-ssrc = false
              node.always-process = false
              sess.media = "audio"
              audio.format = "S16BE"
              audio.rate = 48000
              audio.channels = 2
              audio.position = [ FL FR ]
              stream.props = {
                media.class = "Audio/Source"
                node.name = "rtp-source"
              }
          }
      }
      ]
    '';
  };
}
