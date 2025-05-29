{ pkgs, ... }:
let
  eye-care-reminder-script = pkgs.writeShellScriptBin "eye-care-reminder" ''
    isLocked=$(qdbus org.kde.screensaver /ScreenSaver org.freedesktop.ScreenSaver.GetActive 2>/dev/null)
    if [[ $isLocked == "false" ]]; then
      ifLock=$(notify-send "You have been using the screen for more than 20 minutes. Take a break." --icon system-lock-screen --action "Lock Screen" --app-name WSdlly02)
      if [[ $ifLock == 0 ]]; then
        qdbus org.kde.screensaver /ScreenSaver org.freedesktop.ScreenSaver.Lock
      fi
    fi
  '';
in
{
  systemd.user = {
    services.eye-care-reminder = {
      Unit = {
        Description = "eye-care-reminder service";
        After = "graphical-session.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = eye-care-reminder-script;
        Environment = [ "PATH=${pkgs.kdePackages.qttools}/bin" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
    timers.eye-care-reminder = {
      Unit.Description = "Timer for eye-care-reminder";
      Timer = {
        OnBootSec = "20min";
        OnUnitActiveSec = "20min";
        AccuracySec = "60s";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
