{pkgs, ...}: {
  imports = [
    ./home-manager
  ];
	programs.nix-ld.enable = true;
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      # id-generator is in home-manager
      ncdu
    ];
  };
}
