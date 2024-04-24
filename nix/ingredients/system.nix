{ config, pkgs, ...}:

{
  time.timeZone = "Asia/Tokyo";

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.consoleLogLevel = 0;
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

# hardware
  sound.enable = true;
  hardware.pulseaudio.enable = true;

# battery
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

# bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

}
