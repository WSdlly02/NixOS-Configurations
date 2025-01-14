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
  };

  outputs = {
    self,
    nixpkgs-unstable,
    home-manager,
    lanzaboote,
    nixos-hardware,
    nix-minecraft,
  } @ inputs: {
    devShells = {
      "x86_64-linux" = let
        pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
      in {
        # rocm-python312-env = pkgs.mkShell {packages = [];};
        nixfmt = pkgs.callPackage ./WSdlly02-PC/Packages/devShell-nixfmt.nix {};
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
          ./WSdlly02-PC/Hardware
          ./WSdlly02-PC/Programs/Basic
          ./WSdlly02-PC/Programs/Daily
          ./WSdlly02-PC/Programs/Development
          ./WSdlly02-PC/Programs/Gaming
        ];
      };
      "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "aarch64-linux"; # buildPlatform
        modules = [
          # TBD
          nix-minecraft.nixosModules.minecraft-servers
          nixos-hardware.nixosModules.raspberry-pi-5
          ./WSdlly02-RaspberryPi5/Hardware
          ./WSdlly02-RaspberryPi5/Programs/Basic
          ./WSdlly02-RaspberryPi5/Programs/Daily
          ./WSdlly02-RaspberryPi5/Programs/Gaming
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
