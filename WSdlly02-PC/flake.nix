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
    devShells."x86_64-linux" = {
      # rocm-python312-env = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in pkgs.mkShell {packages = [];};
      nixfmt = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in import ./Packages/devShell-nixfmt.nix {inherit pkgs;};
    };
    nixosConfigurations = let
      specialArgs = {inherit inputs;};
    in {
      "WSdlly02-PC" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          lanzaboote.nixosModules.lanzaboote
          ./configuration.nix
        ];
      };
      "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "aarch64-linux";
        modules = [
          # TBD
        ];
      };
      "Lily-PC" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          # TBD
        ];
      };
      "WSdlly02-LT-WSL" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          # TBD
        ];
      };
    };
  };
}
