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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      home-manager,
      my-codes,
      nixos-hardware,
      nixos-wsl,
      nixpkgs-unstable,
      self,
      zen-browser,
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
          default = my-codes.devShells."${system}".default;
          nixfmt = callPackage ./pkgs/devShells-nixfmt.nix { };
        }
      );

      formatter = forExposedSystems (system: (mkPkgs { inherit system; }).nixfmt-rfc-style);

      legacyPackages = forExposedSystems (
        system:
        {
          my-codes.exposedPackages = my-codes.overlays.exposedPackages null (mkPkgs {
            inherit system;
          });
          nixpkgs-unstable.exposedPackages = mkPkgs { inherit system; };
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
            allowAliases = false;
            allowUnfree = true;
            rocmSupport = true;
            warnUndeclaredOptions = true;
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
            self.nixosModules.default
            ./host-specific/WSdlly02-PC
            # TODO: libvirt
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
            self.nixosModules.default
            ./hostSpecific/WSdlly02-RaspberryPi5
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
            self.nixosModules.default
            ./host-specific/WSdlly02-LT-WSL
          ];
        };
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
          self.nixosModules.default
        ];
      };
      nixosModules.default = {
        imports = [ ./modules ];
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
