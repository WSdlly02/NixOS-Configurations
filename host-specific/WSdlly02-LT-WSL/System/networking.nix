{
  config,
  ...
}:
{
  networking = {
    hostName = config.system.name;
    firewall.enable = false;
    timeServers = [
      "ntp.ntsc.ac.cn"
      "cn.ntp.org.cn"
    ];
  };
  services.timesyncd.servers = config.networking.timeServers;
}
