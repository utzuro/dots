{ config, pkgs, ...}:

{
  nix.settings.substituters = [ "https://cuda-maintainers.cachix.org" ];
  services.xserver.videoDrivers = 
  [ 
    "nvidia"
    "modesetting"
  ];

  # Virtualization
  hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # use it with offload on hybrid laptop
    powerManagement.finegrained = false;
    open = true; # currently alpha-quality
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    prime = {
      sync.enable = true;
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";
    };

  };
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    cudaPackages.cuda_cccl
    cudaPackages.cudnn
    cudatoolkit
    ocl-icd
    #rocm-opencl-runtime
    vulkan-tools
  ];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
}
