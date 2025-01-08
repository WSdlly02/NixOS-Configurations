{
  pkgs,
  inputs,
  ...
}: {
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
    ];
    stateVersion = "24.11";
  };
}
