{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hostUserSpecific;
in
{
  imports = [ ./sh.nix ];
  options.hostUserSpecific = {
    username = lib.mkOption {
      default = "wsdlly02";
      type = lib.types.str;
      description = "user managed by home-manager";
    };
    extraPackages = lib.mkOption {
      default = [ ];
      type = lib.types.listOf lib.types.package;
      description = ''
        The set of packages that appear in home
      '';
    };
  };
  config = {
    programs = {
      command-not-found = {
        enable = true;
        dbPath = "${pkgs.self.outPath}/programs.sqlite";
      };
      home-manager.enable = true;
      lazygit.enable = true;
      nh = {
        enable = true;
        flake = "${config.home.homeDirectory}/Documents/nix-config";
      };
    };
    home = {
      username = cfg.username;
      homeDirectory = "/home/${cfg.username}";
      packages =
        with pkgs;
        [
          fastfetch
          currentNixConfig
          nixd
          nixfmt-rfc-style
          nix-diff
          nix-output-monitor
          nix-tree
          id-generator
          yazi
        ]
        ++ cfg.extraPackages;
      sessionVariables = {
        MY_CODES_PATH = "${config.home.homeDirectory}/Documents/my-codes";
        NIX_CONFIG_PATH = "${config.home.homeDirectory}/Documents/nix-config";
      };
    };
  };
}
