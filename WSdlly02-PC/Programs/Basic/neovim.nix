{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          LazyVim
          lazy-nvim
          lazygit-nvim
        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [];
      };
    };
  };
}
