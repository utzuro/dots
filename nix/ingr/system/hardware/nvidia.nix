{ config, pkgs, ... }:

{
  nix.settings = {
    substituters = [ "https://cuda-maintainers.cachix.org" ];
    trusted-public-keys = [ "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E=" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false; # Only for Optimus laptops
    open = false; # still beta
    # Options: stable, beta, production, vulkan_beta, legacy_*
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # Load nvidia modules early in initrd for better compatibility
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  # Blacklist nouveau to prevent conflicts
  boot.blacklistedKernelModules = [ "nouveau" ];

  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    cudaPackages.cuda_cccl
    cudatoolkit
    ocl-icd
    vulkan-tools
    vulkan-loader
    mesa-demos # For debugging: glxinfo | grep -i nvidia
    pciutils # lspci to check GPU
  ];

  environment.sessionVariables = {
    # Hardware acceleration
    LIBVA_DRIVER_NAME = "nvidia";
    # For Electron apps on Wayland
    NIXOS_OZONE_WL = "1";
  };
}
