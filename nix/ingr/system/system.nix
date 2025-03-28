{ pkgs, ...}:

{
  hardware = {
    enableAllFirmware = true;
    sensor.iio.enable = true;
  };
  environment.pathsToLink = [ "/libexec" ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    tmp.cleanOnBoot = true;
  };

  security.rtkit.enable = true;
  services = { 
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true; 
    }; 
    dbus = { enable = true; };
    udev = { 
      enable = true; 
      packages = with pkgs; [ platformio-core openocd ];
    };
    sysprof = { enable = true; };
  };

  programs.nix-ld.package = pkgs.nix-ld-rs; 

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    acpi lm_sensors sysprof
    alsa-utils coppwr helvum pwvucontrol
    wireplumber easyeffects
    zsh vim tmux git curl wget ranger
    ack ripgrep eza bat peco progress jq
    htop zenith
    playerctl pavucontrol
    gparted hw-probe ntfs3g
    home-manager
  ];

}
