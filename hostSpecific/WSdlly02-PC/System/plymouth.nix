{ pkgs, ... }:
{
  boot.plymouth = with pkgs; {
    enable = true;
    theme = "hexagon_dots";
    themePackages = [
      (adi1090x-plymouth-themes.override { selected_themes = [ "hexagon_dots" ]; })
    ];
  };
}
