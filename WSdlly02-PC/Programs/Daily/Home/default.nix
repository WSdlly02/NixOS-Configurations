{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.wsdlly02 = import ./wsdlly02.nix;
    extraSpecialArgs = inputs;
  };
}
