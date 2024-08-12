{ config, pkgs, lib, ...}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
      libva libva-utils
      nvidia-vaapi-driver
      cudaPackages.cuda_cccl
      vaapiIntel
      vaapiVdpau
      vulkan-validation-layers
      rocmPackages.clr.icd #amd 
    ]; 
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
  }; 

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

  # nvidia
  hardware.nvidia.powerManagement.enable = true;
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  hardware.nvidia.open = false;

  # amd
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
} 
