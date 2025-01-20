{pkgs, ...}: {
  imports = [
    ./home-manager
  ];
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      # id-generator is in home-manager
      ncdu
    ];
  };
}
