{
  description = "WSdlly02's NixOS flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    my-codes = {
      url = "github:WSdlly02/my-codes/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      flake-parts,
      home-manager,
      lanzaboote,
      nixos-hardware,
      my-codes,
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      ## These are the options of flake-parts
      flake.nixosConfigurations = {
        "WSdlly02-PC" = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            lanzaboote.nixosModules.lanzaboote
            # TODO: libvirt
            ./host-specific/WSdlly02-PC/Daily
            ./host-specific/WSdlly02-PC/Gaming
            ./host-specific/WSdlly02-PC/System
            ./modules/Infrastructure
            ./modules/Daily
            ./modules/Development
          ];
        };
        "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "aarch64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            nixos-hardware.nixosModules.raspberry-pi-5
            ./host-specific/WSdlly02-RaspberryPi5/Daily
            ./host-specific/WSdlly02-RaspberryPi5/Gaming
            ./host-specific/WSdlly02-RaspberryPi5/System
            ./modules/Daily
            ./modules/Development
            ./modules/Infrastructure
          ];
        };
        "Lily-PC" = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            { system.name = "Lily-PC"; }
            ./modules/Daily
            ##./modules/Development # Not required
            ./modules/Infrastructure
          ];
        };
        "WSdlly02-LT-WSL" = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            # TBD
          ];
        };
      };

      perSystem =
        {
          inputs',
          ...
        }:
        let
          pkgs = inputs'.nixpkgs-unstable.legacyPackages;
          inherit (pkgs) callPackage;
        in
        {
          devShells = inputs'.my-codes.devShells // {
            # devShells cannot be recursively imported
            # default = inputs'.my-codes.devShells.default;
            nixfmt = callPackage ./pkgs/devShells-nixfmt.nix { };
          };
          formatter = pkgs.nixfmt-rfc-style;
          legacyPackages = {
            # WSdlly02's Codes Library
            my-codes-packages = inputs'.my-codes.legacyPackages;
            # Local pkgs
            epson-inkjet-printer-201601w = callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
            fabric-survival = callPackage ./pkgs/fabric-survival.nix { };
          };
        };
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
