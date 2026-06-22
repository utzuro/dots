# NixOS setup

Preferebly use custom image built in nix/installer

## Boot

Make sure to boot in UEFI mode. VMs sometimes don't do that.

## Network

On VM use bridged NAT mode. IPv4 address should be assigned automatically.
On physical machines use ethernet cable/phone tethering or connect to wifi via nmtui

Note: used to use wpa_supplicant but had issues here and there

## Partitioning

Building btrfs based encrypted filesystem.

```sh
lsblk -f # choose which disk to use
```

Use @disk-config to partition. Replace the /dev/sda with target disk and run:
`sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix`

Check with: `mount | grep /mnt`.

Then generate basic configs with `sudo nixos-generate-config --no-filesystems --root /mnt`.
