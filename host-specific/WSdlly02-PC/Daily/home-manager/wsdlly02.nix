{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./fish-config.nix
    ./psd.nix
    ./roc-sink.nix
    ./syncthing.nix
  ];
  programs = {
    home-manager.enable = true;
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
  services.mpris-proxy.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      id-generator
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
