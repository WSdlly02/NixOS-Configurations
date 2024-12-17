{
  boot.kernel.sysctl = {
    # Network
    "net.core.netdev_max_backlog" = 16384;
    "net.core.rmem_default" = 1048576;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_default" = 1048576;
    "net.core.wmem_max" = 16777216;
    "net.core.optmem_max" = 65536;
    "net.core.default_qdisc" = "cake";
    # net.ipv4.tcp_congestion_control = bbr; It has been set as default
    "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_window_scaling" = 1;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_timestamps" = 0;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.udp_rmem_min" = 8192;
    "net.ipv4.udp_wmem_min" = 8192;
    # System
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 20;
  };
}
