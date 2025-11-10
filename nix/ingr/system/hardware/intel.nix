{ config, pkgs, lib, ... }:

{

  hardware = {

    cpu.intel.updateMicrocode = true;
    # intelgpu = {
    #   driver = "xe";
    # };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
    };

  };

} 
