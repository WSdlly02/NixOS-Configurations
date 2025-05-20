{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./sh.nix
  ];
  programs = {
    command-not-found = {
      enable = true;
      dbPath = "/nix/programs.sqlite";
    };
    home-manager.enable = true;
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Documents/NixOS-Configurations";
    };
  };
  home = rec {
    username = "wsdlly02";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      ncmdump
      id-generator
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
