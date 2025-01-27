{
  description = "WSdlly02's NixOS flake";

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
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
      nix-minecraft,
      my-codes,
    }@inputs:
    let
      forAllSystems = nixpkgs-unstable.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          # rocm-python312-env = pkgs.mkShell {packages = [];};
          nixfmt = pkgs.callPackage ./pkgs/devShell-nixfmt.nix { };
        }
      );

      formatter = forAllSystems (system: nixpkgs-unstable.legacyPackages.${system}.nixfmt-rfc-style);

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          # WSdlly02's Codes Library
          inC = my-codes.packages.${system}.inC;
          inPython = my-codes.packages.${system}.inPython;
          inRust = { };
          # Local pkgs
          epson-inkjet-printer-201601w = pkgs.callPackage ./pkgs/epson-inkjet-printer-201601w.nix { }; # Do not work on aarch64
          python312FHSEnv = pkgs.callPackage ./pkgs/python312FHSEnv.nix { };
        }
      );

      nixosConfigurations =
        let
          specialArgs = { inherit inputs; };
        in
        {
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
              ./host-specific/WSdlly02-PC/System
              ./modules/Infrastructure
              ./modules/Daily
              ./modules/Development
            ];
          };
          "WSdlly02-RaspberryPi5" = nixpkgs-unstable.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";
            modules = [
              home-manager.nixosModules.home-manager
              nixos-hardware.nixosModules.raspberry-pi-5
              nix-minecraft.nixosModules.minecraft-servers
              ./host-specific/WSdlly02-RaspberryPi5/Daily
              ./host-specific/WSdlly02-RaspberryPi5/Gaming
              ./host-specific/WSdlly02-RaspberryPi5/System
              ./modules/Daily
              ##./modules/Development # Not required
              ./modules/Infrastructure
            ];
          };
          "Lily-PC" = nixpkgs-unstable.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              { system.name = "Lily-PC"; }
              ./modules/Daily
              ##./modules/Development # Not required
              ./modules/Infrastructure
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
