{pkgs, ...}: {
  programs = {
    fuse.userAllowOther = true;
    fish.enable = true;
    vim = {
      enable = true;
      defaultEditor = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
    };
    htop.enable = true;
    bandwhich.enable = true;
    # usbtop.enable = true;
    adb.enable = true;
  };
  services = {
    dbus.implementation = "broker";
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    journald = {
      storage = "auto";
      extraConfig = ''
        Compress=true
        SystemMaxUse=512M
      '';
    };
  };
  users.users.wsdlly02 = {
    isNormalUser = true;
    uid = 1000;
    group = "wheel";
    extraGroups = ["users" "adbusers"];
  };
  environment.systemPackages = with pkgs; [
    # Drivers and detection tools
    bind
    btop
    corkscrew
    cryptsetup
    iperf
    killall
    lm_sensors
    lsof
    nix-output-monitor
    nix-tree
    nmap
    rar
    ripgrep
    rsync
    id-generator
    sshfs-fuse
    fastfetch
    tree
    unrar
    unzip
    wget
    zip
  ];
  nixpkgs.overlays = [
    (self: super: {
      id-generator = pkgs.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> /mnt/c/Users/WSdlly02/Documents/id-list.txt
        echo $sha512ID >> /mnt/c/Users/WSdlly02/Documents/id-list.txt
        echo $sha512ID
      '';
    })
  ];
}
