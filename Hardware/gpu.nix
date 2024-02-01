{
  hardware.opengl = {
    ## radv: an open-source Vulkan driver from freedesktop
    driSupport = true;
    driSupport32Bit = true;
    #environment.variables.AMD_VULKAN_ICD = "RADV";

    ## amdvlk: an open-source Vulkan driver from AMD
    #extraPackages = [ pkgs.libva ];
    #extraPackages32 = [ pkgs.driversi686Linux.mesa ];
  };
}
