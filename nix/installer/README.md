# Custom NixOS Installation

## Build an ISO

```sh
export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-25.05
 nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage
```

## Load to the VM / Burn to the USB drive

```sh
ff?
```

## Boot they installer and SSH into it

Inital password: `tmp`
