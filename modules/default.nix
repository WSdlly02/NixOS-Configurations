{ config, lib, ... }:
{
  imports = [
    ./modules/Daily
    ./modules/Development
    ./modules/Infrastructure
  ];
  options.hostSpecific = {
    isDesktop = lib.mkOption {
      type = lib.types.boolean;
      default = False;
      description = "foo package to use.";
    };
    isLaptop = lib.mkOption {
      type = lib.types.boolean;
      default = False;
      description = "foo package to use.";
    };
    powersave = lib.mkOption {
      type = lib.types.boolean;
      default = False;
      description = "foo package to use.";
    };
    bluetooth.nix.enable = lib.mkOption {
      type = lib.types.boolean;
      default = False;
      description = "foo package to use.";
    };
    defaultUser = lib.mkOption {
      type = lib.types.string;
      default = "";
      description = "foo package to use.";
    };

  };
}
