{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set WSdlly02_PC_hostname $(avahi-resolve-address -n -4 WSdlly02-PC.local | awk -F " " '{print $2}')
        alias exportproxy='export https_proxy=http://$WSdlly02_PC_hostname:7890 http_proxy=http://$WSdlly02_PC_hostname:7890 all_proxy=http://$WSdlly02_PC_hostname:7890'
      '';
    };
  };
}
