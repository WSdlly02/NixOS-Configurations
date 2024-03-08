{ pkgs, ... }:

{
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
    fcitx5-chinese-addons
    fcitx5-gtk
    ];
  };
}