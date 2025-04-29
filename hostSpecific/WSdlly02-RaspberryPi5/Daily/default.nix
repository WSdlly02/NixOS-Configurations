{ pkgs, ... }:
{
  imports = [
    ./home-manager
  ];
  environment = {
    defaultPackages = with pkgs; [
      fastfetch
      ncdu
    ];
  };
}
