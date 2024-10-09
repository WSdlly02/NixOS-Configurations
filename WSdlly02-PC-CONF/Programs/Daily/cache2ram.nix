{pkgs, ...}: let
  microsoft-edge-cache2ram-main = pkgs.writeShellScript "microsoft-edge-cache2ram-main" ''
      case "$1" in
    import)
      cd /dev/shm
      ${pkgs.zstd}/bin/zstd -dc /home/wsdlly02/.cache/microsoft-edge-cache-backup.tar.zst | ${pkgs.gnutar}/bin/tar xf -
      ${pkgs.zstd}/bin/zstd -dc /home/wsdlly02/.cache/microsoft-edge-config-backup.tar.zst | ${pkgs.gnutar}/bin/tar xf -
    ;;
    dump)
      cd /dev/shm
      ${pkgs.gnutar}/bin/tar cf - microsoft-edge-cache/ | ${pkgs.zstd}/bin/zstd > /home/wsdlly02/.cache/microsoft-edge-cache-backup.tar.zst
      ${pkgs.gnutar}/bin/tar cf - microsoft-edge-config/ | ${pkgs.zstd}/bin/zstd > /home/wsdlly02/.cache/microsoft-edge-config-backup.tar.zst
    ;;
    *)
    exit 1
    ;;
    esac
    exit 0
  '';

  microsoft-edge-cache2ram-startup = pkgs.writeShellScript "microsoft-edge-cache2ram-startup" ''
    mkdir -p /dev/shm/microsoft-edge-cache
    mkdir -p /dev/shm/microsoft-edge-config
    ${pkgs.util-linux}/bin/mount --bind /dev/shm/microsoft-edge-cache /home/wsdlly02/.cache/microsoft-edge
    ${pkgs.util-linux}/bin/mount --bind /dev/shm/microsoft-edge-config /home/wsdlly02/.config/microsoft-edge
    ${microsoft-edge-cache2ram-main} import
    ${pkgs.coreutils}/bin/chown wsdlly02:wheel -R /dev/shm/microsoft-edge-cache
    ${pkgs.coreutils}/bin/chown wsdlly02:wheel -R /dev/shm/microsoft-edge-config
  '';

  microsoft-edge-cache2ram-shutdown = pkgs.writeShellScript "microsoft-edge-cache2ram-shutdown" ''
    ${microsoft-edge-cache2ram-main} dump
    ping -c 4 127.0.0.1 > /dev/null
  '';
in {
  systemd.services.microsoft-edge-cache2ram = {
    enable = true;
    unitConfig = {
      Description = "Synchronize microsoft-edge caches between ram and disk";
      PartOf = "graphical.target";
      DefaultDependencies = "no";
      Before = ["umount.target" "shutdown.target" "reboot.target" "halt.target"];
      RequiresMountsFor = ["/home"];
    };
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = true;
      ExecStart = "${microsoft-edge-cache2ram-startup}";
      ExecStop = "${microsoft-edge-cache2ram-shutdown}";
    };
    wantedBy = ["graphical.target"];
  };
}
