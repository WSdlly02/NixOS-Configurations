{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.hostSpecific;
in
{
  imports = [ ./sh.nix ];
  options.hostSpecific = {
    username = lib.mkOption {
      default = "wsdlly02";
      type = lib.types.str;
      description = "default user to operate system";
    };
  };
  config = {
    home = {
      username = cfg.username;
      homeDirectory = "/home/${cfg.username}";
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
  };
}
