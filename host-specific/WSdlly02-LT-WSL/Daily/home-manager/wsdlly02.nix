{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./fish-config.nix
  ];
  programs.home-manager.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      id-generator
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
