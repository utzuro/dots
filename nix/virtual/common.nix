{ ... }:

{
  # Minimal defaults so the virtual guest profile evaluates without a generated
  # hardware-configuration.nix. Override these per hypervisor image if needed.
  boot.loader.grub.devices = [ "/dev/sda" ];
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
}
