{
  config,
  lib,
  enableInfrastructure, # !!!
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    programs.ccache = {
      enable = true;
      packageNames = [
      ] ++ config.hostSpecific.programs.ccache.extraPackageNames;
      # Which adds ccacheStdenv to overlays
    };
  };
}
