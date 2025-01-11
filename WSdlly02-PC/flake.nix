{
  description = "WSdlly02's NixOS flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    my-codes = {
      url = "/home/wsdlly02/Documents/Codes";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {
    self,
    nixpkgs-unstable,
    home-manager,
    lanzaboote,
    nixos-hardware,
    nix-minecraft,
    my-codes,
  } @ inputs: {
    packages = {
      "x86_64-linux" = {
        inC = my-codes.packages."x86_64-linux".inC;
        inPython = my-codes.packages."x86_64-linux".inPython;
        inRust = {};
      };
      "aarch64-linux" = {};
    };
    devShells = {
      "x86_64-linux" = let
        pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
      in {
        # rocm-python312-env = pkgs.mkShell {packages = [];};
        nixfmt = import ./Packages/devShell-nixfmt.nix {inherit pkgs;};
      };
      "aarch64-linux" = {};
    };
    nixosConfigurations = let
      specialArgs = {inherit inputs;};
    in {
      "WSdlly02-PC" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          lanzaboote.nixosModules.lanzaboote
          nix-minecraft.nixosModules.minecraft-servers
          # TODO: nix-minecraft libvirt
          ./Hardware
          ./Hardware/bootloader.nix
          ./Programs/Basic
          ./Programs/Daily
          ./Programs/Development
          ./Programs/Gaming
        ];
      };
      "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux"; # buildPlatform
        modules = [
          # TBD
          nix-minecraft.nixosModules.minecraft-servers
          nixos-hardware.nixosModules.raspberry-pi-5
          {
            nixpkgs.crossSystem = {
              # Target platform, cross compiling
              system = "aarch64-linux";
            };
          }
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
