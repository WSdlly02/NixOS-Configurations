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
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-25_05.url = "github:NixOS/nixpkgs/309871725f09fffa92d7d97a213c3a9f88672265";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/main";
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
      nixpkgs-25_05,
      self,
      zen-browser,
    }@inputs:
    let
      inherit (nixpkgs-unstable) lib;
      inherit (self.lib) mkPkgs;
      exposedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forExposedSystems = lib.genAttrs exposedSystems;
    in
    {
      devShells = forExposedSystems (
        system: with (mkPkgs { inherit system; }); {
          default = my-codes.devShells."${system}".default;
          nixfmt = callPackage ./pkgs/devShells-nixfmt.nix { };
        }
      );

      formatter = forExposedSystems (system: (mkPkgs { inherit system; }).nixfmt-rfc-style);

      homeConfigurations = {
        "wsdlly02@WSdlly02-PC" = home-manager.lib.homeManagerConfiguration {
          modules = [
            self.homeModules.default
            zen-browser.homeModules.beta
            ./hostSpecific/WSdlly02-PC/Home
          ];
          pkgs = mkPkgs { system = "x86_64-linux"; };
        };
        "wsdlly02@WSdlly02-LT-WSL" = home-manager.lib.homeManagerConfiguration {
          modules = [
            self.homeModules.default
            ./hostSpecific/WSdlly02-LT-WSL/Home
          ];
          pkgs = mkPkgs { system = "x86_64-linux"; };
        };
        "wsdlly02@WSdlly02-RaspberryPi5" = home-manager.lib.homeManagerConfiguration {
          modules = [
            self.homeModules.default
            ./hostSpecific/WSdlly02-RaspberryPi5/Home
          ];
          pkgs = mkPkgs { system = "aarch64-linux"; };
        };
      };

      homeModules.default = {
        _module.args = { inherit inputs; };
        imports = [ ./modules/homeModules ];
      };

      legacyPackages = forExposedSystems (
        system:
        {
          my-codes-exposedPackages = my-codes.overlays.exposedPackages null (mkPkgs {
            inherit system;
          });
          nixpkgs-unstable = mkPkgs { inherit system; };
          nixpkgs-25_05 = mkPkgs {
            nixpkgsInstance = nixpkgs-25_05;
            inherit system;
          };
        }
        // self.overlays.exposedPackages null (mkPkgs {
          inherit system;
        })
        // self.overlays.id-generator-overlay null (mkPkgs {
          inherit system;
        })
      );

      lib.mkPkgs =
        {
          nixpkgsInstance ? nixpkgs-unstable,
          config ? { },
          overlays ? [ ],
          system,
        }:
        import nixpkgsInstance {
          inherit system;
          config = {
            allowAliases = false;
            allowUnfree = true;
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
          system = "x86_64-linux";
          pkgs = mkPkgs {
            inherit system;
            overlays = [ self.overlays.nixpkgs-25_05-overlay ];
          };
          modules = [
            self.nixosModules.default
            ./hostSpecific/WSdlly02-PC
            # TODO: libvirt
          ];
        };
        "WSdlly02-RaspberryPi5" = lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = mkPkgs {
            config.rocmSupport = false;
            inherit system;
          };
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-5
            self.nixosModules.default
            ./hostSpecific/WSdlly02-RaspberryPi5
          ];
        };
        "WSdlly02-LT-WSL" = lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs {
            config.rocmSupport = false;
            inherit system;
          };
          modules = [
            nixos-wsl.nixosModules.default
            self.nixosModules.default
            ./hostSpecific/WSdlly02-LT-WSL
          ];
        };
        "Lily-PC" = lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = mkPkgs {
            config.rocmSupport = false;
            inherit system;
          };
          modules = [
            { system.name = "Lily-PC"; }
            self.nixosModules.default
          ];
        };
      };

      nixosModules.default = {
        _module.args = { inherit inputs; };
        imports = [ ./modules/nixosModules ];
      };

      overlays = {
        exposedPackages =
          final: prev: with prev; {
            currentNixConfig = callPackage ./pkgs/currentNixConfig.nix { inherit inputs; };
            epson-inkjet-printer-201601w = callPackage ./pkgs/epson-inkjet-printer-201601w.nix { };
            fabric-survival = callPackage ./pkgs/fabric-survival.nix { };
          };
        nixpkgs-25_05-overlay =
          final: prev: with prev; {
            pkgs-25_05 = mkPkgs {
              nixpkgsInstance = nixpkgs-25_05;
              system = "${stdenv.hostPlatform.system}";
            };
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
