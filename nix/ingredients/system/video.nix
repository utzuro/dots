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
    # amd
    amdvlk
    driversi686Linux.amdvlk
    radeontop
    rocm-opencl-icd
    rocm-opencl-runtime
    xorg.xf86videoamdgpu
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}
