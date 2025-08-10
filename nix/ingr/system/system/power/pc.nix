# Power settings that doesn't save any power
{ config, pkgs, ... }:

{
  boot = {
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_schedutil" ];
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
}
