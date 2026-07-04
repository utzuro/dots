{
  config,
  pkgs,
  lib,
  ...
}:

{

  hardware = {

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
        libvdpau-va-gl
        libva
        libva-utils
        libva-vdpau-driver
        vulkan-validation-layers
        vulkan-headers
      ];
    };

  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';

  # v4l2loopback is provided for the running kernel via
  # boot.extraModulePackages above — never install it for a different kernel.
  environment.systemPackages = with pkgs; [
    mesa
    mesa-demos
  ];
}
