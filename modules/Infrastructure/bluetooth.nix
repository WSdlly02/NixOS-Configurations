{
  config,
  lib,
  enableInfrastructure,
  ...
}:
{
  config = lib.mkIf enableInfrastructure {
    hardware.bluetooth = {
      enable = config.hostSpecific.enableBluetooth;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
          FastConnectable = true;
          KernelExperimental = true;
          Experimental = true;
        };
      };
    };
  };
}
