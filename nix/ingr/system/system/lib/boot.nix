{ pkgs, ...}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" "ext4" "xfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    # initrd.systemd.extraConfig = ''
    #   DefaultTimeoutStartSec=10s
    # '';
    initrd.verbose = true;
    tmp.cleanOnBoot = true;
  };
}
