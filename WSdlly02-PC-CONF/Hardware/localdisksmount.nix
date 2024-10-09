#NTFS Disks mounting
{
  fileSystems."/home/wsdlly02/Disks/Files-M" = {
    device = "/dev/disk/by-uuid/29B31A33EBBBBC0B";
    fsType = "ntfs";
    options = ["x-systemd.automount" "noauto" "nofail" "rw" "user_id=0" "group_id=0" "allow_other" "blksize=4096"];
  };
}
