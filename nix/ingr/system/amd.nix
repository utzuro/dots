{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    amdvlk
    radeontop
    driversi686Linux.amdvlk
    rocmPackages.clr.icd
    rocm-opencl-icd
    rocm-opencl-runtime
    xorg.xf86videoamdgpu
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
} 
