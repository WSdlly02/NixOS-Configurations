{ pkgs, ... }:
{
  imports = [ ./home-manager ];
  environment = {
    localBinInPath = true;
    systemPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
