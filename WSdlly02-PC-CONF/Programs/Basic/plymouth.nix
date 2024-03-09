{ config, pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [
      adi1090x-plymouth-themes
    ];
    theme = "red_loader";
  };
  systemd.services.plymouth-wait-for-animation = {
    enable = true;
    before = ["plymouth-quit.service" "display-manager.service"];
    wantedBy = ["plymouth-start.service"];
    unitConfig = { Description = "Waits for Plymouth animation to finish"; };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/sleep 6";
    };
  };
}