{
  description = "WSdlly02's NixOS flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    # Notice to add https://github.com/gytis-ivaskevicius/flake-utils-plus
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      home-manager,
      lanzaboote,
      nixos-hardware,
      my-codes,
    }@inputs:
    let
      forAllSystems = nixpkgs-unstable.lib.genAttrs [
        # Currently supported systems
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs-unstable.legacyPackages.${system};
          inherit (pkgs) callPackage mkShell;
        in
        {
          my-codes-devShells = my-codes.devShells.${system};
          nixfmt = callPackage ./pkgs/devShell-nixfmt.nix { };
        }
      );

      formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-rfc-style);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs-unstable.legacyPackages.${system};
          inherit (pkgs) callPackage;
        in
        {
          # WSdlly02's Codes Library
          my-codes-packages = my-codes.packages.${system};
          # Local pkgs
          epson-inkjet-printer-201601w = callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
          fabric-survival = callPackage ./pkgs/fabric-survival.nix { };
        }
      );

      nixosConfigurations = {
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
    };
}
