{pkgs, ...}: {
  programs = {
    fuse.userAllowOther = true;
    fish.enable = true;
    vim.enable = true;
    vim.defaultEditor = true;
    git.enable = true;
    htop.enable = true;
    adb.enable = true;
  };
  services = {
    dbus.implementation = "broker";
  };
  users.users.wsdlly02 = {
    isNormalUser = true;
    uid = 1000;
    group = "wheel";
    extraGroups = ["users" "adbusers"];
  };
  environment.systemPackages = with pkgs; [
    # Drivers and detection tools
    sshfs-fuse
    usbutils
    pciutils
    lm_sensors
    # Basic programs
    wget
    dig
    curl
    nmap
    lsof
    killall
    cryptsetup
    iperf
    zip
    unzip
    rsync
    corkscrew # ssh tunnel
    nix-output-monitor
  ];
  nixpkgs.overlays = [
    (self: super: {
      id-generator = pkgs.writeShellScriptBin "id-generator" ''
        sha512ID=$(echo -n $1 | sha512sum | head -zc 8)
        echo $1 >> ~/Documents/id-list.txt
        echo $sha512ID >> ~/Documents/id-list.txt
        echo $sha512ID
      '';
    })
  ];
}
