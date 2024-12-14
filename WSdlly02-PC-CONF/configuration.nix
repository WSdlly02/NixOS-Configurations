{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Hardware and drivers configuration
    ./Hardware
    # Basic programs configuration
    ./Programs/Basic
    # Daily programs configuration
    ./Programs/Daily
    # Development tools
    ./Programs/Development
    # Gaming
    ./Programs/Gaming
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "auto";
    };
    timeout = 10;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
  };

  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  # font = "Lat2-Terminus16";
  # keyMap = "us";
  # useXkbConfig = true; # use xkb.options in tty.
  # };

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
  services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # services.fwupd.enable = true;
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
  system.stateVersion = "24.11"; # Did you read the comment?
  system.name = "WSdlly02-PC";
}
