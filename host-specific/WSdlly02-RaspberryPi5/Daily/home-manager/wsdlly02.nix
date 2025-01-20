{
  pkgs,
  inputs,
  ...
}: {
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      # inputs.self.packages."..."
    ];
    stateVersion = "25.05";
    file = {
      roc-source = {
        text = ''
          context.modules = [
            { name = libpipewire-module-roc-source
              args = {
                local.ip = 10.42.0.2
                resampler.profile = high
                fec.code = ldpc
                sess.latency.msec = 50
                local.source.port = 10001
                local.repair.port = 10002
                local.control.port = 10003
                source.name = "ROC Source"
                source.props = {
                  node.name = "roc-source"
                }
              }
            }
          ]
        '';
        target = ".config/pipewire/pipewire.conf.d/20-roc-source.conf";
      };
    };
  };
}
