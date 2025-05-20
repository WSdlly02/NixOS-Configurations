{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ##./roc-source.nix cannot work !!!
    ./sh.nix
    ./syncthing.nix
  ];
  programs = {
    command-not-found = {
      enable = true;
      dbPath = "/nix/programs.sqlite";
    };
    home-manager.enable = true;
    lazygit.enable = true;
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Documents/NixOS-Configurations";
    };
    java = {
      enable = true;
      package = pkgs.zulu21;
    };
  };
  services.mpris-proxy.enable = true;
  home = rec {
    username = "wsdlly02";
    homeDirectory = "/home/${username}";
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
  targets.genericLinux.enable = true;
}
