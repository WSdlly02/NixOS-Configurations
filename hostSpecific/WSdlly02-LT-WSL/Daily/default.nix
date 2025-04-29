{ pkgs, ... }:
{
  imports = [ ./home-manager ];
  environment = {
    systemPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
