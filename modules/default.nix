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
    boot.kernel.sysctl."vm.swappiness" = lib.mkOption {
      type = lib.types.int;
      default = 20;
      description = ''
        This option defines the value of vm.swappiness
      '';
    };
    enableBtrfsScrub = lib.mkEnableOption "Enable Btrfs scrub";
    enableDevelopment = lib.mkEnableOption "Enable Development Env";
    enableInfrastructure = lib.mkEnableOption "Install infrastructure softwares";
    enableBluetooth = lib.mkEnableOption "Enable bluetooth";
    enableSmartd = lib.mkEnableOption "Enable smart daemon";
    environment.extraSystemPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = ''
        The set of packages that appear in
        /run/current-system/sw
      '';
    };
    defaultUser = {
      name = lib.mkOption {
        type = lib.types.str;
        default = "wsdlly02";
        description = "default user to operate system";
      };
      linger = lib.mkEnableOption "set linger in logind";
      extraGroups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "The user's auxiliary groups.";
      };
    };
    networking.firewall = {
      extraAllowedPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [ ];
        apply = ports: lib.unique (builtins.sort builtins.lessThan ports);
        description = ''
          List of ports on which incoming connections are
          accepted.
        '';
      };
      extraAllowedPortRanges = lib.mkOption {
        type = lib.types.listOf (lib.types.attrsOf lib.types.port);
        default = [ ];
        description = ''
          A range of ports on which incoming connections are
          accepted.
        '';
      };
    };
    nix.settings.max-jobs = lib.mkOption {
      type = lib.types.int;
      default = 32;
      description = ''
        This option defines the maximum number of jobs that Nix will try to
        build in parallel.
      '';
    };
    programs = {
      ccache.extraPackageNames = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Nix top-level packages to be compiled using CCache";
        default = [ ];
      };
      proxychains.proxies.host = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1";
        description = "default proxy addr";
      };
    };
    services.pipewire.socketActivation = lib.mkEnableOption "Enable socketActivation";
  };
  config = {
    _module.args = {
      # Add configs to specialArgs in order to accelerate eval
      enableDevelopment = cfg.enableDevelopment;
      enableInfrastructure = cfg.enableInfrastructure;
    };
  };
}
