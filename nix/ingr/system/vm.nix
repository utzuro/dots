# Full-power VM guest profile: VMware Workstation/Fusion guests on
# Windows/macOS hosts. Keeps the physical hosts' encrypted btrfs layout;
# LUKS unlock comes from boot.nix (partition labelled `nixenc`), so import
# this together with ../system/boot.nix. Lightweight qemu-on-Linux guests
# use microvm.nix instead.

{ lib, ... }:

{
  # VMware guest integration (open-vm-tools: clipboard, time sync,
  # display resize, shared folders).
  virtualisation.vmware.guest.enable = true;

  boot.initrd.availableKernelModules = [
    "mptspi"
    "vmw_pvscsi"
    "ahci"
    "nvme"
    "sd_mod"
    "sr_mod"
  ];

  # Same encrypted btrfs subvolume scheme as the physical machines, but by
  # label instead of hardware-configuration UUIDs. Label the btrfs inside
  # the LUKS container `nixos` and the ESP `boot` during install.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/log" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "btrfs";
    options = [
      "subvol=log"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  hardware.graphics.enable = true;

  # No firmware blobs needed in a VM; keeps the closure small.
  hardware.enableAllFirmware = lib.mkForce false;
  hardware.enableRedistributableFirmware = lib.mkForce false;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
