{
  pkgs,
  inputs,
  ...
}: {
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      id-generator = pkgs.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> ~/Documents/id-list.txt
        echo $sha512ID >> ~/Documents/id-list.txt
        echo $sha512ID
      '';
    })
  ];
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      id-generator
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
