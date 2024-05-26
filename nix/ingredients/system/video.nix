{ config, pkgs, ...}:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
    rocmPackages.clr.icd #amd
  ];
}
