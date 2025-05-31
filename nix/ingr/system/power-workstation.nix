{ pkgs, ...}:

{
  boot = {
    kernelModules = [ "xe" "i2c-dev" "i2c-piix4" "intel_idle.max_cstate=1" "i915.enable_dc=0" "ahci.mobile_lpm_policy=1" ];
  };

  boot.initrd.kernelModules = ["xe"];

  # This is a workaround for the i915 driver but causes battery drain
  # intel_idle.max_cstate=1 i915.enable_dc=0 ahci.mobile_lpm_policy=1
  # https://wiki.archlinux.org/title/Intel_graphics#Crash/freeze_on_low_power_Intel_CPUs

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "balanced"; # "powersave" / "performance" / "powersave"
  };

  logind = {
    lidSwitch = "suspend-then-hibernate";
  };
  thermald.enable = true;

  tlp = {
    enable = true;
    settings = {
      # https://discourse.nixos.org/t/nixos-power-management-help-usb-doesnt-work/9933/2
      # sudo tlp-stat to see current and possbile values

      # CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_BATTERY = "balanced";
      START_CHARGE_THRESH_BAT0 = 80;
      STOP_CHARGE_THRESH_BAT0 = 95;
      TLP_DEFAULT_MODE = "BAT";
      # Tell tlp to always run in default mode
      # TLP_PERSISTENT_DEFAULT = 1;
      # INTEL_GPU_MIN_FREQ_ON_AC = 500;
      # INTEL_GPU_MIN_FREQ_ON_BAT = 500;

      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      USB_AUTOSUSPEND = 0;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      cpufrequtils 
      cpupower-gui
      powerstat
    ];
  };
}

