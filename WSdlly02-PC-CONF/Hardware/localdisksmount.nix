#NTFS Disks mounting
{
  fileSystems."/home/wsdlly02/Disks/Files" =
    { device = "/dev/disk/by-uuid/5224F93524F91CA3";
      fsType = "ntfs";
      options = [ "rw" "user_id=0" "group_id=0" "allow_other" "blksize=4096" ];
    };
  
  fileSystems."/home/wsdlly02/Disks/Files-N" =
    { device = "/dev/disk/by-uuid/A2B8D793B8D763F7";
      fsType = "ntfs";
      options = [ "rw" "user_id=0" "group_id=0" "allow_other" "blksize=4096" ];
    };
  
  fileSystems."/home/wsdlly02/Disks/Files-E" =
    { device = "/dev/disk/by-uuid/927A1EBB7A1E9C53";
      fsType = "ntfs";
      options = [ "rw" "user_id=0" "group_id=0" "allow_other" "blksize=4096" ];
    };
  
  fileSystems."/home/wsdlly02/Disks/Files-M" =
    { device = "/dev/disk/by-uuid/29B31A33EBBBBC0B";
      fsType = "ntfs";
      options = [ "rw" "user_id=0" "group_id=0" "allow_other" "blksize=4096" ];
    };
}