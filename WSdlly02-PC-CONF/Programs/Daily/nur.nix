{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  environment.defaultPackages = with pkgs; [
    nur.repos.xddxdd.dingtalk
    nur.repos.linyinfeng.wemeet
    ##nur.repos.xddxdd.lantianLinuxXanmod.latest-x86_64-v3-lto
  ];
}
