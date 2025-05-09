{
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
      flake = "/etc/nixos";
    };
  };
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      ncmdump
      id-generator
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
