{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.luks.devices = {
    nixenc = {
      device = "/dev/disk/by-uuid/044cda8f-a267-4b82-9382-f8358fd56cec";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/log" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/srv" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=srv" "compress=zstd" "noatime" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/b7f5a68a-15c6-425a-84d2-19c972bb5031";
      fsType = "btrfs";
      options = [ "subvol=var" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/32B6-A501";
      fsType = "vfat";
    };

  fileSystems."/mnt/archive" =
    { device = "/dev/disk/by-uuid/8462E9A862E99EE4";
      fsType = "ntfs3";
      options = [ "noatime" "nofail" "rw" "uid=1000" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6bf11f0e-b471-471d-94a9-f68b5110abb5"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
