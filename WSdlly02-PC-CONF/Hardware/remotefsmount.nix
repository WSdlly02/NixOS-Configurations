{
  fileSystems."/home/wsdlly02/Disks/Lily-PC" = 
    { device = "lily@lily-pc.local:/";
      fsType = "fuse.sshfs";
      options = [ "x-systemd.automount" "_netdev" "users" "idmap=user" 
      "IdentityFile=/home/wsdlly02/.ssh/id_rsa_lily"
      "allow_other" "reconnect" "ServerAliveInterval=15" "port=10022"
      ];
    };
}