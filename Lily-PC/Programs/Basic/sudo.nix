{
  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''Defaults env_keep += "http_proxy https_proxy all_proxy"'';
  };
}
