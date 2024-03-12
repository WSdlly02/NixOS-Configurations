{
  programs.tmux = {
    enable = true;
    historyLimit = 4000;
    clock24 = true;
    extraConfig = "set -g mouse on";
  };
}