# NTFS Disks mounting
{
  fileSystems = {
    "/home/wsdlly02/Disks/Files-M" = {
      device = "/dev/disk/by-uuid/29B31A33EBBBBC0B";
      fsType = "ntfs3";
      depends = ["/home"];
      noCheck = true;
      options = ["rw"];
    };
    "/home/wsdlly02/Disks/Files" = {
      device = "/dev/disk/by-uuid/D85499D95499BAA8";
      fsType = "ntfs3";
      depends = ["/home"];
      noCheck = true;
      options = ["rw"];
    };
  };
}
