{ inputs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.wsdlly02 = import ./wsdlly02.nix;
    users.will117 = import ./will117.nix;
    extraSpecialArgs = inputs;
  };
}
