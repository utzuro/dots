{ config, pkgs, lib, ...}:

{
  hardware = {

    graphics = {
    enable = true;
    enable32Bit = true; 
    extraPackages = with pkgs; [
      vpl-gpu-rt
      libvdpau-va-gl
      libva libva-utils
      vaapiIntel
      vaapiVdpau
      vulkan-validation-layers
    ]; 
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];

    cpu.intel.updateMicrocode = true;
  }; 

  # hardware.intelgpu = {
  #   driver = "xe";
  # };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.v4l2loopback
  ];
} 
