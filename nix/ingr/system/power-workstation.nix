{ config, pkgs, ...}:

{
  boot = {
    kernelModules = [ "xe", "i2c-dev" "i2c-piix4","intel_idle.max_cstate=1" "i915.enable_dc=0" "ahci.mobile_lpm_policy=1" ];
  };

  # This is a workaround for the i915 driver but causes battery drain
  # intel_idle.max_cstate=1 i915.enable_dc=0 ahci.mobile_lpm_policy=1
  # https://wiki.archlinux.org/title/Intel_graphics#Crash/freeze_on_low_power_Intel_CPUs

  # powerManagement.enable = true;
  # services.tlp.enable = true;
  # services.thermald.enable = true; #fails on start for some reason

  environment = {
    systemPackages = with pkgs; [
      cpufrequtils 
      cpupower-gui
      powerstat
      tlp
    ];
  };
}

