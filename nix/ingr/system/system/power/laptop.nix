# Power settings that try to keep battery alive as much as possible
{ config, pkgs, ...}:

{
  boot = {
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_powersave" ];
  };

  powerManagement.enable = true; # managed by tlp
  services.thermald.enable = true;
  # services.tlp.enable = true;

  environment = {
    systemPackages = with pkgs; [
      cpufrequtils 
      cpupower-gui
      powerstat
      # tlp
    ];
  };
}

