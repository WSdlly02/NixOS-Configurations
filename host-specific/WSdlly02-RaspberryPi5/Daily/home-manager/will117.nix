{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ ];
  programs.home-manager.enable = true;
  home = {
    username = "will117";
    homeDirectory = "/home/will117";
    packages = with pkgs; [
      nnn
      # inputs.self.legacyPackages."..."
    ];
    stateVersion = "25.05";
  };
}
