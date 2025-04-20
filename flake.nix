{
  description = "WSdlly02's NixOS flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    my-codes = {
      url = "github:WSdlly02/my-codes/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      home-manager,
      my-codes,
      nixos-hardware,
      nixos-wsl,
      nixpkgs-unstable,
      self,
    }@inputs:
    let
      inherit (nixpkgs-unstable) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = lib.genAttrs systems;
      pkgs =
        system:
        nixpkgs-unstable.legacyPackages."${system}".appendOverlays [
          (final: prev: {
            config = prev.config // {
              allowUnfree = true;
              allowUnsupportedSystem = true;
              enableParallelBuilding = true;
              rocmSupport = true;
            };
          })
          self.overlays.id-generator-overlay
          self.overlays.legacyPackagesExposed
          my-codes.overlays.legacyPackagesExposed
        ];

    in
    {
      nixosConfigurations = {
        "WSdlly02-PC" = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            # TODO: libvirt
            ./host-specific/WSdlly02-PC/Daily
            ./host-specific/WSdlly02-PC/Gaming
            ./host-specific/WSdlly02-PC/System
            ./modules/Infrastructure
            ./modules/Daily
            ./modules/Development
          ];
        };
        "WSdlly02-RaspberryPi5" = lib.nixosSystem {
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
        "Lily-PC" = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            { system.name = "Lily-PC"; }
            ./modules/Daily
            ##./modules/Development # Not required
            ./modules/Infrastructure
          ];
        };
        "WSdlly02-LT-WSL" = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            nixos-wsl.nixosModules.default
            ./host-specific/WSdlly02-LT-WSL/Daily
            ./host-specific/WSdlly02-LT-WSL/System
            ./modules/Daily
            ./modules/Development
            # TBD
          ];
        };
      };
      overlays = {
        id-generator-overlay = final: prev: {
          id-generator = prev.writeShellScriptBin "id-generator" ''
            sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
            echo $1 >> ~/Documents/id-list.txt
            echo $sha512ID >> ~/Documents/id-list.txt
            echo $sha512ID
          '';
        };
        legacyPackagesExposed = final: prev: {
          epson-inkjet-printer-201601w = prev.callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
          fabric-survival = prev.callPackage ./pkgs/fabric-survival.nix { };
        };
      };
      devShells = forAllSystems (
        system: with (pkgs system); {
          default = inputs.my-codes.devShells."${system}".default;
          nixfmt = callPackage ./pkgs/devShells-nixfmt.nix { };
        }
      );
      formatter = forAllSystems (system: (pkgs system).nixfmt-rfc-style);
      legacyPackages = forAllSystems (
        system: with (pkgs system); {
          my-codesLegacyPackagesExposed = inputs.my-codes.legacyPackages."${system}";
          epson-inkjet-printer-201601w = callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
          fabric-survival = callPackage ./pkgs/fabric-survival.nix { };
        }
      );
    };
}
