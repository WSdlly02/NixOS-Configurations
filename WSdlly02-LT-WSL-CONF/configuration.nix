# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    #<nixos-wsl/modules>
    ./Programs/Basic/basic.nix
    ./Programs/Basic/networking.nix
    ./Programs/Basic/openssh.nix
    ./Programs/Basic/sudo.nix
    ./Programs/Basic/tmux.nix
  ];
  
  # wsl.enable = true;
  # wsl.defaultUser = "nixos";
  # Already defined in flake.nix

  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "C.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_PAPER = "C.UTF-8";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      max-jobs = 64;
      substituters = lib.mkForce [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      auto-optimise-store = true;
      experimental-features = lib.mkForce [
        "nix-command"
        "flakes"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  system.name = "WSdlly02-LT-WSL";
}
