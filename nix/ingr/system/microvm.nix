# Lightweight QEMU/KVM guest profile for VMs run on a Linux host
# (libvirt/plain qemu). Plain unencrypted disk, minimal guest services.
# Not used by nix/microvm (the microvm.nix framework manages its own
# boot and storage); full-power VMware guests use vm.nix instead.

{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  # Plain virtio disk, no LUKS inside the guest. Label the partitions
  # `nixos` / `boot` when creating the VM disk.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    tmp.cleanOnBoot = true;
  };

  # Guest integrations: clipboard/resize via SPICE, host control via the
  # QEMU guest agent, virtio-accelerated graphics for the WM.
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  hardware.graphics.enable = true;

  # No firmware blobs needed in a VM; keeps the closure small.
  hardware.enableAllFirmware = lib.mkForce false;
  hardware.enableRedistributableFirmware = lib.mkForce false;

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
