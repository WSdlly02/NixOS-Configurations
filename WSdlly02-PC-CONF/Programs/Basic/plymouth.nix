{pkgs, ...}: {
  boot.plymouth = {
    enable = true;
    themePackages = [pkgs.adi1090x-plymouth-themes];
    theme = "hexagon_dots_alt";
  };
  systemd.services.plymouth-wait-for-animation = {
    enable = true;
    before = ["plymouth-quit.service" "display-manager.service"];
    wantedBy = ["plymouth-start.service"];
    unitConfig = {Description = "Waits for Plymouth animation to finish";};
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.coreutils}/bin/sleep 4";
    };
  };
}
