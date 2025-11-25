{ config, pkgs, ... }:

{
  nix.settings.substituters = [ "https://cuda-maintainers.cachix.org" ];
  services.xserver.videoDrivers =
    [
      "nvidia"
      "modesetting"
    ];

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # use it with offload on hybrid laptop
    powerManagement.finegrained = false;
    open = true; # currently alpha-quality
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    cudaPackages.cuda_cccl
    # cudaPackages.cudnn
    cudatoolkit
    ocl-icd
    vulkan-tools
  ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
