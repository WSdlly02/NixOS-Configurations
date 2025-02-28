{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./fish-config.nix
    ./roc-source.nix
    ./syncthing.nix
    ./python-web-server.nix
  ];
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      id-generator
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "25.05";
  };
}
