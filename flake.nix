{
  description = "WSdlly02's NixOS flake";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-unstable";
    };
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
      flake-parts,
      home-manager,
      my-codes,
      nixos-hardware,
      nixos-wsl,
      nixpkgs-unstable,
      self,
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      ## These are the options of flake-parts
      flake.nixosConfigurations = {
        "WSdlly02-PC" = nixpkgs-unstable.lib.nixosSystem {
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
          # pkgs = import inputs.nixpkgs-unstable { # We can use overlays here
          #   inherit system;
          #   overlays = [ inputs.self.overlays.id-generator-overlay ];
          # };
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

      flake.overlays = {
        id-generator-overlay = final: prev: {
          id-generator = prev.writeShellScriptBin "id-generator" ''
            sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
            echo $1 >> ~/Documents/id-list.txt
            echo $sha512ID >> ~/Documents/id-list.txt
            echo $sha512ID
          '';
        };
      };

      perSystem =
        {
          inputs',
          system,
          ...
        }:
        let
          pkgs = import nixpkgs-unstable {
            inherit system;
            config = {
              allowUnfree = true;
            };
            overlays = [ self.overlays.id-generator-overlay ];
          };
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
