{
  lib,
  pkgs,
  ...
}: {
  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
    plasmaBrowserIntegrationPackage = lib.mkForce pkgs.kdePackages.plasma-browser-integration;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
}
