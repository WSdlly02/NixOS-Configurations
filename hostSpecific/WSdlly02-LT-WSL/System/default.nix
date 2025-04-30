{
  imports = [
    #./i18n.nix
    #./neovim.nix
    ./networking.nix
    #./nix.nix
    ./nixpkgs-x86_64.nix
    #./sudo.nix
    #./tmux.nix
  ];
  wsl = {
    enable = true;
    defaultUser = "wsdlly02";
    interop.register = true;
    useWindowsDriver = true;
  };
}
