{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
