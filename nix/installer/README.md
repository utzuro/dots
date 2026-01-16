# Custom NixOS Installation

## Create a hashedPasswordFile

```sh
passwd > hashedPasswordFile
# rm the word "password:" from the generated file
```

## Build an ISO

```sh
export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-unstable
 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage
```

## Load to the VM / Burn to the USB drive

```sh
ff?
```

## Boot the installer and SSH into it
