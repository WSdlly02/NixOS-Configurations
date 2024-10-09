{
  services.smartdns = {
    enable = true;
    bindPort = 53;
    settings = {
      bind-tcp = "[::]:53";
      mdns-lookup = true;
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
      server = ["240e:58:c000:1600:180:168:255:18" "240e:58:c000:1000:116:228:111:118" "116.228.111.118" "180.168.255.18" "240e:38c:8258:3900:72a8:d3ff:fe56:4a82" "223.5.5.5" "114.114.114.114" "2400:3200::1" "117.50.11.11" "1.1.1.1 -proxy socks5" "8.8.8.8 -proxy socks5"];
      server-https = "https://dns.alidns.com/dns-query";
      server-tls = "dns.alidns.com";
      dualstack-ip-selection = true;
      dualstack-ip-selection-threshold = 10;
    };
  };
}
