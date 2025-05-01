{ pkgs, ... }:
{
  environment = {
    defaultPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
