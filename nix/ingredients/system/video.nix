{ config, pkgs, ...}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.graphics.extraPackages = with pkgs; 
  [
    # rocmPackages.clr.icd #amd
  ];

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.v4l2loopback
  ];
}
