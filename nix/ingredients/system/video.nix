{ config, pkgs, lib, ...}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.graphics.extraPackages = with pkgs; 
  [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
      nvidia-vaapi-driver
      cudaPackages.cuda_cccl
      vaapiIntel
      vaapiVdpau
      vulkan-validation-layers
      rocmPackages.clr.icd #amd
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
