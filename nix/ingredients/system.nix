{ config, pkgs, ...}:

{
  hardware.enableAllFirmware = true;
  environment.pathsToLink = [ "/libexec" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    # use cpufreq_powersave to save power
    kernelModules = [ "i2c-dev" "i2c-piix4" "cpufreq_schedutil" ];
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

# hardware
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

# battery
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

# bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

# TimeZone
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    # some shell available for the root
    zsh vim tmux git wget ranger
    ack peco progress jq
  ];
}
