{ pkgs, ... }:
{
  imports = [ ./home-manager ];
  programs.nix-ld.enable = true;
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
