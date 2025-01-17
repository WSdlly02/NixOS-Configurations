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
    stateVersion = "25.05";
    file = {
      remote-bluetooth-receiver = {
        text = ''
          pulse.cmd = [
            { cmd = "load-module" args = "module-native-protocol-tcp listen=10.42.0.2" flags = [ ] }
            { cmd = "load-module" args = "module-zeroconf-publish" flags = [ ] }
          ]
        '';
        target = ".config/pipewire/pipewire-pulse.conf.d/remote-bluetooth-receiver.conf";
      };
    };
  };
}
