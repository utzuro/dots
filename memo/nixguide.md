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
