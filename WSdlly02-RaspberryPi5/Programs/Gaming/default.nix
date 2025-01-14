{pkgs, ...}: {
  imports = [
    #./minecraft-server.nix
  ];
  programs = {
    java = {
      enable = true;
      package = pkgs.zulu21;
    };
  };
}
