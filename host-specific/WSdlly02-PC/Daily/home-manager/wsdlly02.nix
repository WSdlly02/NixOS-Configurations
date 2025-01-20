{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./psd.nix
  ];
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
        target = ".config/pipewire/pipewire.conf.d/20-roc-sink.conf";
      };
    };
  };
}
