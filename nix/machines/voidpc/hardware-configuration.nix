# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.luks.devices = {
    nixenc = {
      device = "/dev/disk/by-uuid/ab07f3ec-0277-4eaf-b559-9fb70be67248";
      preLVM = true;
      allowDiscards = true;
    };
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b1f2c704-09ee-4382-b2f6-9fe304e3832f";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/b1f2c704-09ee-4382-b2f6-9fe304e3832f";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b1f2c704-09ee-4382-b2f6-9fe304e3832f";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/log" =
    { device = "/dev/disk/by-uuid/b1f2c704-09ee-4382-b2f6-9fe304e3832f";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
    };

  fileSystems."/mnt/seance" =
    { device = "/dev/disk/by-uuid/360f587c-63c3-4161-894b-3ee9b5021fca";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "nofail"];
    };

  fileSystems."/mnt/summons" =
    { device = "/dev/disk/by-uuid/829465d4-6783-4eb6-9f36-9abd3bcdfeb1";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "nofail"];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A8DA-E9CE";
      fsType = "vfat";
    };

  fileSystems."/mnt/db" =
    { device = "/dev/disk/by-uuid/AC1E8BBD1E8B7ED8";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/archive" =
    { device = "/dev/disk/by-uuid/C0CA129FCA1291B0";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/zalot" =
    { device = "/dev/disk/by-uuid/B43C9C923C9C516A";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  #fileSystems."/mnt/li" =
  #  { device = "/dev/disk/by-uuid/182ABA512ABA2B9E";
  #    fsType = "ntfs3";
  #    options = [ "rw" "uid=1000" "nofail" "noatime" ];
  #  };

  fileSystems."/mnt/portal" =
    { device = "/dev/disk/by-uuid/58AE3902AE38D9E8";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/darkarts" =
    { device = "/dev/disk/by-uuid/E006CE2306CDFB14";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };
   
  fileSystems."/mnt/archivum" =
    { device = "/dev/disk/by-uuid/3A7C6B1B7C6AD0E5";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/awaw" =
    { device = "/dev/disk/by-uuid/3E46DA2646D9DF29";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/356d8adc-29d3-4f3d-8966-7780968aab3c"; 
        options = [ "noatime" ];
      }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s20f0u4u4.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
