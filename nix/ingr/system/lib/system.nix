{ pkgs, lib, ... }:

{

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    ipu6.enable = true;
    # ipu6 for Tiger Lake
    # ipu6ep for Alder Lake / Raptor Lake
    # ipu6epmtl for Meteor Lake.
    ipu6.platform = "ipu6ep";
    # extra
    flipperzero.enable = true;
    sensor.iio.enable = true;
  };
  environment.pathsToLink = [ "/libexec" ];

  security.rtkit.enable = true;
  services = {
    gnome.gnome-keyring.enable = true;
    gvfs = {
      enable = true;
      package = lib.mkForce pkgs.gvfs;
    };
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
    dbus.enable = true;
    udev = {
      enable = true;
      packages = with pkgs; [ platformio-core openocd ];
    };
    sysprof = { enable = true; };
  };

  # Allows nix-ld to be used as the default linker.
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
    ## If needed, you can add missing libraries here. nix-index-database is your friend to
    ## find the name of the package from the error message:
    ## https://github.com/nix-community/nix-index-database
    # libraries = options.programs.ni
  };

  # Drasticly increases the disk space usage but allows offline rebuiles
  system.includeBuildDependencies = true;
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    LC_CTYPE = "en_US.UTF8";
    LC_ADDRESS = "es_VE.UTF-8";
    LC_MEASUREMENT = "es_VE.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "es_VE.UTF-8";
    LC_NAME = "es_VE.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "es_VE.UTF-8";
    LC_TELEPHONE = "es_VE.UTF-8";
    LC_TIME = "es_VE.UTF-8";
    LC_COLLATE = "es_VE.UTF-8";
  };
}
