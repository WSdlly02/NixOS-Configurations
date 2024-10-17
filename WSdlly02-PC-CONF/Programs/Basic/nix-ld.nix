{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      steam-run.fhsenv.args.multiPkgs
    ];
  };
}
