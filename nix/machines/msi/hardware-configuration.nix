{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot = {
      initrd = {
        availableKernelModules = [ 
          "xhci_pci"
          "thunderbolt"
          "vmd"
          "nvme"
          "usb_storage"
          "sd_mod"
          "rtsx_pci_sdmmc"
          "aesni_intel" 
          "cryptd"
        ];
        kernelModules = [ 
          "xe" # use "i915" instead of xe if issues
          "i915"
          "nvidia" 
          "nvidia_drm" 
          "nvidia_modeset" 
          "nvidia_uvm" 
        ]; 
      };
      kernelModules = [ "kvm-intel" ];
      # blacklistedKernelModules = [ "serial8250" "tpm_crb" "tpm_tis" ];

      # https://wiki.archlinux.org/title/Intel_graphics#Crash/freeze_on_low_power_Intel_CPUs
      kernelParams = [ 
        # Don't go to deep sleep completely (freeze)
        # "intel_idle.max_cstate=1" 

        # tryint to solve ssd issues (was solved by disabling VMD)
        # "nvme.noacpi=1"
        # "nvme_core.default_ps_max_latency_us=0"
        # "pcie_aspm=off"

        # Drain battery but be stable
        # "iommu.strict=1"
        # "ahci.mobile_lpm_policy=1" 
        # "vmd.allow_msix=0"
        # "8250.nr_uarts=0"
        # "mitigations=off"

        # To fix X failing
        "xe.force_probe=7d55" 

        # Stop freeze on boot
        "i915.enable_dc=0" 
        "i915.enable_psr=0"
      ];
      extraModulePackages = [ ];
    };

  boot.initrd.luks.devices."luks-1123808c-135b-4c84-b4c1-6c317d567301".device = "/dev/disk/by-uuid/1123808c-135b-4c84-b4c1-6c317d567301";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/55e3191b-34ac-45f9-a0fd-a3b246bb5baa";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A08D-1AA6";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/zalot" =
    { device = "/dev/disk/by-uuid/B43C9C923C9C516A";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/awaw" =
    { device = "/dev/disk/by-uuid/3E46DA2646D9DF29";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };

  fileSystems."/mnt/archive" =
    { device = "/dev/disk/by-uuid/C0CA129FCA1291B0";
      fsType = "ntfs3";
      options = [ "rw" "uid=1000" "nofail" "noatime" ];
    };


  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp44s0f0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
