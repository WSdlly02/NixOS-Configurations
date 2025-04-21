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
      inherit (self) mkPkgs;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forExposedSystems = lib.genAttrs systems;
    in
    {
      devShells = forExposedSystems (
        system: with (mkPkgs { inherit system; }); {
          default = inputs.my-codes.devShells."${system}".default;
          nixfmt = callPackage ./pkgs/devShells-nixfmt.nix { };
        }
      );

      formatter = forExposedSystems (system: (mkPkgs { inherit system; }).nixfmt-rfc-style);

      legacyPackages = forExposedSystems (
        system:
        with (mkPkgs { inherit system; });
        {
          my-codesExposedPackages = inputs.my-codes.legacyPackages."${system}";
          nixpkgsExposedPackages = mkPkgs { inherit system; };
        }
        // self.overlays.exposedPackages null (mkPkgs {
          inherit system;
        })
        // self.overlays.id-generator-overlay null (mkPkgs {
          inherit system;
        })
      );

      mkPkgs =
        {
          config ? { },
          overlays ? [ ],
          system,
        }:
        import nixpkgs-unstable {
          inherit system;
          config = {
            allowUnfree = true;
            enableParallelBuilding = true;
            rocmSupport = true;
          } // config;
          overlays = [
            my-codes.overlays.exposedPackages
            self.overlays.exposedPackages
            self.overlays.id-generator-overlay
          ] ++ overlays;
        };

      nixosConfigurations = {
        "WSdlly02-PC" = lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.pkgs = mkPkgs {
                inherit system;
              };
            }
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
        "WSdlly02-RaspberryPi5" = lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
          system = "aarch64-linux";
          modules = [
            {
              nixpkgs.pkgs = mkPkgs {
                config.rocmSupport = false;
                inherit system;
              };
            }
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
        "Lily-PC" = lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.pkgs = mkPkgs {
                config.rocmSupport = false;
                inherit system;
              };
            }
            { system.name = "Lily-PC"; }
            ./modules/Daily
            ##./modules/Development # Not required
            ./modules/Infrastructure
          ];
        };
        "WSdlly02-LT-WSL" = lib.nixosSystem rec {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.pkgs = mkPkgs {
                config.rocmSupport = false;
                inherit system;
              };
            }
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
        exposedPackages =
          final: prev: with prev; {
            epson-inkjet-printer-201601w = callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
            fabric-survival = callPackage ./pkgs/fabric-survival.nix { };
          };
        id-generator-overlay =
          final: prev: with prev; {
            id-generator = writeShellScriptBin "id-generator" ''
              sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
              echo $1 >> ~/Documents/id-list.txt
              echo $sha512ID >> ~/Documents/id-list.txt
              echo $sha512ID
            '';
          };
      };
    };
}
