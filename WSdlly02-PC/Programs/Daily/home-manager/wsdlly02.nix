{
  pkgs,
  inputs,
  ...
}: {
  programs.home-manager.enable = true;
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
    ];
    stateVersion = "24.11";
  };
}
