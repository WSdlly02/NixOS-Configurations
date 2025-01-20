{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./psd.nix
    ./roc-sink.nix
  ];
  programs.home-manager.enable = true;
  services.mpris-proxy.enable = true;
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
  home = {
    username = "wsdlly02";
    homeDirectory = "/home/wsdlly02";
    packages = with pkgs; [
      nnn
      id-generator
      # inputs.self.packages."..."
    ];
    stateVersion = "24.11";
  };
}
