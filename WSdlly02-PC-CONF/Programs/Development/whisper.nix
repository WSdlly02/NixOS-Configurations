{ pkgs, ... }:

{ 
  environment.defaultPackages = with pkgs; [
    openai-whisper
  ];
  nixpkgs.config.rocmSupport = true;
}