{pkgs, ...}: {
  imports = [
    ./home-manager
  ];
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      id-generator
      ncdu
    ];
  };
}
