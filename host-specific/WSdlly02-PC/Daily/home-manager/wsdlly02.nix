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
      remote-bluetooth-sender = {
        text = ''
          pulse.cmd = [
            { cmd = "load-module" args = "module-zeroconf-discover latency_msec=50" flags = [ ] }
          ]
        '';
        target = ".config/pipewire/pipewire-pulse.conf.d/remote-bluetooth-sender.conf";
      };
    };
  };
}
