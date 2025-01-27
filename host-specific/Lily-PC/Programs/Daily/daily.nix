{ config, pkgs, ... }:

{
  users.users.lily = {
    isNormalUser = true;
    group = "wheel";
    extraGroups = [
      "users"
      "adbusers"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  environment = {
    localBinInPath = true;
    ##variables =
    defaultPackages = with pkgs; [
      fastfetch
      mcrcon
    ];
  };
}
