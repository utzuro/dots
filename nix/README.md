# My Nix setup

This is my personal nix configs.
The main flake lives at the **repo root** (`~/dots/flake.nix`); shared modules
are under `nix/ingr/` (`system/` for NixOS, `home/` for home-manager).
Platform-specific flakes keep their own directory under `nix/`.

## for the system configuration

Outputs: `voidpc`, `vm`, `x240`. Run from the repo root:

```sh
sudo nixos-rebuild switch --flake .#voidpc
```

## for the home-manager configuration

Outputs: `void`, `ubuntu`.

```sh
home-manager switch --flake .#void
```

use override option to use local home-manager source:

```sh
home-manager switch --flake .#void --override-input home-manager ~/alchemy/summons/nixos/home-manager
```

## platform flakes

- `nix/wsl` — NixOS-WSL system (`.#wsl`) plus its own home profile (`.#void`).
- `nix/darwin` — nix-darwin system (`.#corp`) plus its own home profile (`.#void`).
- `nix/nix-on-droid` — Android phone profile (`nix-on-droid switch --flake .`).
- `nix/virtual` — VM guest-tooling flake (VirtualBox/VMware/Xen).
- `nix/microvm` — standalone MicroVM flake.
- `nix/installer` — live ISO built from `iso.nix` (see `nix/installer/README.md`).

## to update the flake.lock

```sh
nix flake update
```
