{ pkgs, lib, ... }:

{
  boot = {
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    consoleLogLevel = 0;
    supportedFilesystems = {
      btrfs = true;
      ext4 = true;
      xfs = true;
      zfs = lib.mkForce false;
    };
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    # initrd.systemd.extraConfig = ''
    #   DefaultTimeoutStartSec=10s
    # '';
    initrd = {
      verbose = true;
      luks.devices = {
        nixenc = {
          device = "/dev/disk/by-partlabel/nixenc";
          preLVM = true;
          allowDiscards = true;
        };
      };
    };
    tmp.cleanOnBoot = true;
  };

  boot = {
    tmp = {
      useTmpfs = true;
      tmpfsSize = "50%";
    };
  };

  # currently all my systems use btrfs so it makes sense to include unconditionally
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };
}
