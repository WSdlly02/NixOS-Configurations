{
  description = "WSdlly02-PC NixOS flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  }: {
    devShells."x86_64-linux".rocm-python312-env = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in pkgs.mkShell {packages = [];};
    # Notice that the binding will only affect devShells
    nixosConfigurations = {
      WSdlly02-PC = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          lanzaboote.nixosModules.lanzaboote
          ({
            pkgs,
            lib,
            ...
          }: {
            environment.systemPackages = [pkgs.sbctl];
            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              # Other configs will inherit automatically
              enable = true;
              pkiBundle = "/var/lib/sbctl/";
            };
          })
        ];
      };
    };
  };
}
