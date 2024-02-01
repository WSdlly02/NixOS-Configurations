{ config, pkgs, ... }:

{
  security.polkit.enable = true;
  programs.corectrl = {
    enable = true;
    gpuOverclock.ppfeaturemask = "0xffffffff";
    gpuOverclock.enable = true;
  };
  security.polkit.extraConfig = ''
   polkit.addRule(function(action, subject) {
    if ((action.id == "org.corectrl.helper.init" ||
    action.id == "org.corectrl.helperkiller.init") &&
    subject.local == true &&
    subject.active == true &&
    subject.isInGroup("wheel")) {
    return polkit.Result.YES;
    }
   });
  '';
}