{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./roc-sink.nix
    ./sh.nix
    ./syncthing.nix
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
      discord
      id-generator
      ncmdump
      ocs-desktop
      telegram-desktop
      yazi
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "24.11";
  };
}
