{
  description = "WSdlly02-PC NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    ...
  }: {
    /*
    devShells."x86_64-linux".rocm-python312-env = let
      pkgs = import nixpkgs {system = "x86_64-linux";}; # Notice that it will only affect devShells
    in
      pkgs.mkShell {packages = [];};
    */
    nixosConfigurations.WSdlly02-PC = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        lanzaboote.nixosModules.lanzaboote
        ({
          pkgs,
          lib,
          ...
        }: {
          environment.systemPackages = [
            # For debugging and troubleshooting Secure Boot.
            pkgs.sbctl
          ];
          # Lanzaboote currently replaces the systemd-boot module.
          # This setting is usually set to true in configuration.nix
          # generated at installation time. So we force it to false
          # for now.
          boot.loader.systemd-boot.enable = lib.mkForce false;
          boot.lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl/";
          };
        })
        ./configuration.nix
      ];
    };
  };
}
