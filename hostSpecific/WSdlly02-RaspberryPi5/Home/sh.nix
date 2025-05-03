{
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        export GPG_TTY=$(tty)
      '';
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        fastfetch
        set WSdlly02_PC_hostname $(avahi-resolve-address -n -4 WSdlly02-PC.local | awk -F " " '{print $2}')
        alias exportproxy='export https_proxy=http://$WSdlly02_PC_hostname:7890 http_proxy=http://$WSdlly02_PC_hostname:7890 all_proxy=http://$WSdlly02_PC_hostname:7890'
      '';
      shellInit = ''
        export GPG_TTY=$(tty)
      '';
    };
  };
}
