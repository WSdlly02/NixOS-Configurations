{pkgs, ...}: {
  imports = [
    ##./minecraft-server.nix
  ];
  programs.java = {
    enable = true;
    package = pkgs.zulu21;
  };
  environment.defaultPackages = with pkgs; [
    mcrcon
  ];
}
