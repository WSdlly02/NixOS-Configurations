{
  home.file."fish-config" = {
    text = ''
      if status is-interactive
        fastfetch
        export GPG_TTY=$(tty)
        set WSdlly02_RaspberryPi5_hostname $(avahi-resolve-address -n -4 WSdlly02-RaspberryPi5.local | awk -F " " '{print $2}')
        alias exportproxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=http://127.0.0.1:7890'
        alias dl='aria2c -d ~/Downloads --allow-overwrite=true --max-tries=5 --max-file-not-found=2 --max-concurrent-downloads=16 --connect-timeout=5 --timeout=5 --split=16 --min-split-size=2M --lowest-speed-limit=20K --max-connection-per-server=16 --uri-selector=feedback'
        alias harvista-server-backup="rsync -aPHSzd -e 'ssh -p 10022 -i ~/.ssh/id_rsa' wsdlly02@$WSdlly02_RaspberryPi5_hostname:/home/wsdlly02/Harvista-Sever-v2.4/ /home/wsdlly02/Documents/Harvista-Sever-v2.4-backup/"
      end
    '';
    target = ".config/fish/config.fish";
  };
}
