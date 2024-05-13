{ config, pkgs, ...}:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.opengl.extraPackages = with pkgs; 
  [
    rocmPackages.clr.icd #amd
  ];

  services.xserver.videoDrivers = 
  [ 
    "nvidia"
    "modesetting" #amd
  ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    # use it with offload on hybrid laptop
    powerManagement.finegrained = false;
# Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    cudatoolkit
    ocl-icd
    rocm-opencl-runtime
  ];
}
