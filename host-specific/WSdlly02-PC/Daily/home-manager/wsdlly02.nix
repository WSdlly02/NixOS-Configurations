{
  pkgs,
  inputs,
  ...
}: {
  programs.home-manager.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      # inputs.self.packages."..."
    ];
    stateVersion = "24.11";
    file = {
      roc-sink = {
        text = ''
          context.modules = [
            { name = libpipewire-module-roc-sink
              args = {
                remote.ip = 10.42.0.2
                fec.code = ldpc
                remote.source.port = 10001
                remote.repair.port = 10002
                remote.control.port = 10003
                sink.name = "ROC Sink"
                sink.props = {
                  node.name = "roc-sink"
                }
              }
            }
          ]
        '';
        target = ".config/pipewire/pipewire.conf.d/roc-sink.conf";
      };
    };
  };
}
