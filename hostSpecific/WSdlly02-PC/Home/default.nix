{
  config,
  pkgs,
  ...
}:
{
  imports = [
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
      flake = "${config.home.homeDirectory}/Documents/NixOS-Configurations";
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
  home = rec {
    username = "wsdlly02";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      discord
      id-generator
      ncmdump
      ocs-desktop
      telegram-desktop
      yazi
      # inputs.self.legacyPackages."..."
    ];
  };
}
