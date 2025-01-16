{pkgs, ...}: {
  environment = {
    localBinInPath = true;
    defaultPackages = with pkgs; [
      fastfetch
      id-generator
      ncdu
      mcrcon
    ];
  };
}
