{pkgs, ...}: {
  # Notice: config.yaml in /etc/lact is not be declared!
  systemd.services.lactd = {
    unitConfig = {
      Description = "AMDGPU Control Daemon";
      After = ["multi-user.target"];
    };
    serviceConfig = {
      ExecStart = "${pkgs.lact}/bin/lact daemon";
      Nice = -10;
      Restart = "on-failure";
    };
    wantedBy = ["multi-user.target"];
  };
}
