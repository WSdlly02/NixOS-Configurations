{ config, lib, ... }:
let
  cfg = config.hostSpecific;
in
{
  imports = [
    ./Daily
    ./Development
    ./Infrastructure
  ];
  options.hostSpecific = {
    enableDevelopment = lib.mkEnableOption "foo package to use.";
    enableInfrastructure = lib.mkEnableOption "foo package to use.";
    # bluetooth = {
    #   enable = lib.mkEnableOption {
    #     type = lib.types.boolean;
    #     default = false;
    #     description = "foo package to use.";
    #   };
    #   powersave = lib.mkOption {
    #     type = lib.types.boolean;
    #     default = false;
    #     description = "foo package to use.";
    #   };
    # };
    defaultUser = lib.mkOption {
      type = lib.types.str;
      default = "wsdlly02";
      description = "default user to operate system";
    };
  };
  config = {
    _module.args = {
      # Add configs to specialArgs in order to accelerate eval
      enableDevelopment = cfg.enableDevelopment;
      enableInfrastructure = cfg.enableInfrastructure;
    };
  };
}
