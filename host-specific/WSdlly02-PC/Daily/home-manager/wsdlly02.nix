{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./fish-config.nix
    ./psd.nix
    ./roc-sink.nix
    ./syncthing.nix
  ];
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      id-generator
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
