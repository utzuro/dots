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

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    zsh vim tmux git wget ranger
    ack peco progress jq
    playerctl cmatrix
    pavucontrol
  ];
}
