{
  pkgs,
  ...
}:
{
  imports = [
    ./sh.nix
  ];
  hostUserSpecific = {
    username = "wsdlly02";
    extraPackages = with pkgs; [
      ncmdump
    ];
  };
  home.stateVersion = "24.11";
}
