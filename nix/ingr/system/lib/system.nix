{ pkgs, lib, ... }:

{

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    # MIPI webcam stack lives in hardware/ipu6.nix — import it only on
    # laptops that actually have an IPU6 camera.
    sensor.iio.enable = true;
  };
  environment.pathsToLink = [ "/libexec" ];

  security.rtkit.enable = true;
  services = {
    gnome.gnome-keyring.enable = lib.mkForce false;
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
      packages = with pkgs; [
        platformio-core
        openocd
      ];
    };
    sysprof = {
      enable = true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd"; # one of "lzo", "lz4", "zstd"
    priority = 5;
    memoryPercent = 50;
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
}
