{
  inputs,
  pkgs,
  ...
}:
{
  systemd.user.services.python-web-server = {
    Unit = {
      Description = "python-web-server";
      RequiresMountsFor = [ "/home/" ];
    };
    Service = {
      ExecStartPre = "${pkgs.networkmanager}/bin/nm-online -q";
      ExecStart = "${
        inputs.my-codes.legacyPackages."aarch64-linux".python312Env
      }/bin/python3.12 /home/wsdlly02/my-codes/Python/server-monitor/app.py";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
