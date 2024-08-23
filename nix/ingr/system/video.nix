{ config, pkgs, lib, ...}:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; 
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      libvdpau-va-gl
      libva libva-utils
      vaapiIntel
      vaapiVdpau
      vulkan-validation-layers
    ]; 
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
  }; 

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.v4l2loopback
  ];
} 
