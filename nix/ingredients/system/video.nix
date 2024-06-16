{ config, pkgs, ...}:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.opengl.extraPackages = with pkgs; 
  [
    # rocmPackages.clr.icd #amd
  ];
}
