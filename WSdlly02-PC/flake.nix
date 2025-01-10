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
    devShells."x86_64-linux" = {
      # rocm-python312-env = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in pkgs.mkShell {packages = [];};
      nixfmt = let pkgs = import nixpkgs-unstable {system = "x86_64-linux";}; in import ./Packages/devShell-nixfmt.nix {inherit pkgs;};
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
            users.users.nixosvmtest.isSystemUser = true;
            users.users.nixosvmtest.initialPassword = "test";
            users.users.nixosvmtest.group = "nixosvmtest";
            users.groups.nixosvmtest = {};
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
