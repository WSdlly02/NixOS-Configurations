{
  pkgs,
  ...
}:
{
  imports = [
    # ./roc-sink.nix
    ./sh.nix
    ./syncthing.nix
  ];
  hostUserSpecific = {
    username = "wsdlly02";
    extraPackages = with pkgs; [
      discord
      ncmdump
      ocs-desktop
      telegram-desktop
    ];
  };
  programs = {
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [ pkgs.firefoxpwa ];
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
  home.stateVersion = "24.11";
  services.mpris-proxy.enable = true;
}
