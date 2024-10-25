{ config, pkgs, ...}:

{
  boot = {
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_powersave" ];
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  environment = {
    systemPackages = with pkgs; [
      cpufrequtils 
      cpupower-gui
      powerstat
      tlp
    ];
  };
}

