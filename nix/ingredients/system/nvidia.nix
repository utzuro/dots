{ config, pkgs, ...}:

{
  services.xserver.videoDrivers = 
  [ 
    "nvidia"
    "modesetting"
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # use it with offload on hybrid laptop
    powerManagement.finegrained = false;
    open = false; # currently alpha-quality
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    cudatoolkit
    ocl-icd
    #rocm-opencl-runtime
    vulkan-tools
  ];
}
