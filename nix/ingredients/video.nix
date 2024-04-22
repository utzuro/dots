{ config, pkgs, ...}:

{
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
    nvidia_x11
    ocl-icd
    rocm-opencl-runtime
  ];
}
