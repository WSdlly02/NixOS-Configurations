{
  pkgs,
  ...
}:
{
  imports = [
    ./fish-config.nix
    ./roc-source.nix
    ./syncthing.nix
  ];
  programs = {
    home-manager.enable = true;
    lazygit.enable = true;
    nh = {
      enable = true;
      flake = "/home/wsdlly02/Documents/NixOS-Configurations";
    };
    java = {
      enable = true;
      package = pkgs.zulu21;
    };
  };
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      fastfetch
      currentSystemConfiguration
      nixd
      nixfmt-rfc-style
      nix-diff
      nix-output-monitor
      nix-tree
      id-generator
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "25.05";
  };
}
