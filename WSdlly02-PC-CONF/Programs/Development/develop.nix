{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    #openai-whisper
  ];
  nixpkgs.config.rocmSupport = true;
  services.tabby = {
    enable = true;
    acceleration = "rocm";
  };
}
