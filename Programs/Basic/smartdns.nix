{
  services.smartdns = {
    enable = true;
    bindPort = 53;
    settings = {
      bind-tcp = "[::]:53";
      # bind-tls = "[::]:53";
      # bind-https = "[::]:53";
      cache-size = 32768;
      cache-persist = true;
      cache-file = "/tmp/smartdns.cache";
      prefetch-domain = true;
      serve-expired-prefetch-time = 21600;
      serve-expired = true;
      serve-expired-ttl = 86400;
      serve-expired-reply-ttl = 3;
      force-qtype-SOA = 65;
      max-reply-ip-num = 16;
      speed-check-mode = "ping tcp:80 tcp:443";
      log-level = "info";
      proxy-server = "socks5://127.0.0.1:7890 -name socks5";
      server = [ "240e:58:c000:1600:180:168:255:18 -weight 100 -blacklist-ip" "240e:58:c000:1000:116:228:111:118 -weight 100 -blacklist-ip" "116.228.111.118 -weight 90 -blacklist-ip" "180.168.255.18 -weight 90 -blacklist-ip" "240e:38c:8258:3900:72a8:d3ff:fe56:4a82 -weight 80 -blacklist-ip" "223.5.5.5 -weight 70 -blacklist-ip" "114.114.114.114 -weight 60 -blacklist-ip" "2400:3200::1 -weight 50 -blacklist-ip" "117.50.11.11 -weight 20 -blacklist-ip" "1.1.1.1 -weight 30 -blacklist-ip -proxy socks5" "8.8.8.8 -weight 30 -blacklist-ip -proxy socks5" ];
      server-https = "https://dns.alidns.com/dns-query -weight 40 -blacklist-ip";
      server-tls = "dns.alidns.com -weight 30 -blacklist-ip";
      dualstack-ip-selection = true;
      dualstack-ip-selection-threshold = 10;
    };
  };
}
