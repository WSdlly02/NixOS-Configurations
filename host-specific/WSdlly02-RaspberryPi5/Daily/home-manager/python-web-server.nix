{inputs}: {
systemd.user.services.python-web-server = {
				Unit = {
								Description = "python-web-server";
								RequiresMountsFor = [ "/home/" ];
				};
				Service = {ExecStart = "${inputs.my-codes.legacyPackages.python312Env}/bin/python3.12 /home/wsdlly02/my-codes/Python/server-monitor/app.py"};
				Install = {WantedBy = [ "default.target" ];};
				};
}
