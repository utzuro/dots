{ pkgs, ...}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ 
      "i915.enable_psr=0"
    ];
    consoleLogLevel = 0;
    supportedFilesystems = [ "btrfs" "ext4" "xfs" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    tmp.cleanOnBoot = true;
  };
}
