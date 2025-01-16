{
  description = "WSdlly02's NixOS flake";
  /*
  nixConfig = {
    extra-substituters = [
      # nix community's cache server
      "https://nix-community.cachix.org"
    ];
    # will be appended to the system-level trusted-public-keys
    extra-trusted-public-keys = [
      # nix community's cache server public key
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  */
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
      url = "github:WSdlly02/my-codes";
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
      "x86_64-linux" = let
        pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
      in {
        # WSdlly02's Codes Library
        inC = my-codes.packages."x86_64-linux".inC;
        inPython = my-codes.packages."x86_64-linux".inPython;
        inRust = {};
        # Local pkgs
        epson-inkjet-printer-201601w = pkgs.callPackage ./pkgs/epson-inkjet-printer-201601w.nix {};
        python312FHSEnv = pkgs.callPackage ./pkgs/python312FHSEnv.nix {};
      };
      "aarch64-linux" = let
        pkgs = import nixpkgs-unstable {system = "aarch64-linux";};
      in {
        python312FHSEnv = pkgs.callPackage ./pkgs/python312FHSEnv.nix {};
      };
    };

    devShells = {
      "x86_64-linux" = let
        pkgs = import nixpkgs-unstable {system = "x86_64-linux";};
      in {
        # rocm-python312-env = pkgs.mkShell {packages = [];};
        nixfmt = pkgs.callPackage ./pkgs/devShell-nixfmt.nix {};
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
          ./host-specific/WSdlly02-PC/Daily
          ./host-specific/WSdlly02-PC/Gaming
          ./host-specific/WSdlly02-PC/Infrastructure
          ./modules/Infrastructure
          ./modules/Daily
          ./modules/Development
          ./modules/Gaming
        ];
      };
      "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        system = "aarch64-linux"; # buildPlatform
        modules = [
          nixos-hardware.nixosModules.raspberry-pi-5
          nix-minecraft.nixosModules.minecraft-servers
          ./host-specific/WSdlly02-RaspberryPi5/Daily
          ./host-specific/WSdlly02-RaspberryPi5/Infrastructure
          ./modules/Infrastructure
          ./modules/Daily
          ./modules/Development
          ./modules/Gaming
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
