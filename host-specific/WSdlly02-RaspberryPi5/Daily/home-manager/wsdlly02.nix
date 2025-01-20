{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./roc-source.nix
    ./syncthing.nix
  ];
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      id-generator
      # inputs.self.packages."..."
    ];
    stateVersion = "25.05";
  };
}
