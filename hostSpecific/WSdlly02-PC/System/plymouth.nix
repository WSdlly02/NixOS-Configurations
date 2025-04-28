{ pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    themePackages = [
      (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "hexagon_dots" ]; })
    ];
    theme = "hexagon_dots";
  };
}
