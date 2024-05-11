{ config, pkgs, ...}:

{
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; 
  [
    rocmPackages.clr.icd #amd
  ];
  services.xserver.videoDrivers = 
  [ 
    "nvidia"
    "modesetting" #amd
  ];
  nixpkgs.config.cudaSupport = true;
  environment.systemPackages = with pkgs; [
    cudatoolkit
    ocl-icd
    rocm-opencl-runtime
  ];
}
