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
      # inputs.self.packages."..."
    ];
    stateVersion = "24.11";
  };
}
