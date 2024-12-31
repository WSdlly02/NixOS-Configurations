{
  description = "WSdlly02-PC NixOS flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs-unstable,
    lanzaboote,
    ...
  } @ inputs: {
    /*
    devShells."x86_64-linux" = {
      rocm-python312-env = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in pkgs.mkShell {packages = [];};
      nix-fmt = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in import ./Packages/devShell.nix {inherit pkgs;};
    };
    # Notice that the binding will only affect devShells
    */
    nixosConfigurations = {
      # WSdlly02-Raspberrypi = nixpkgs-unstable.lib.nixosSystem {}
      WSdlly02-PC = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          lanzaboote.nixosModules.lanzaboote
          (import ./Hardware/lanzaboote.nix)
          ./configuration.nix
        ];
      };
    };
  };
}
