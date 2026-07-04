# Utzuro's configs

Here are my configs, mainly for NixOS and tools like vim, but also for other things.
Some of the configs are applicable to Windows or macOS, but mostly Arch Linux and NixOS.

OS agnostic configs are saved in config directory and they get semilinked (copied on win) by running bootstrap.sh which runs packages/shell.sh.

The main flake.nix lives at the repo root (so pure evaluation works — no `--impure` needed) and imports nix/ingr/home for home-manager related packages and configs and nix/ingr/system for systemwide. Platform-specific flakes (wsl, darwin, installer, microvm, …) stay under nix/.

Rebuild with `nixos-rebuild switch --flake ~/dots#<host>` or `home-manager switch --flake ~/dots#void`.

Settings made for NixOS but most of them are also used by wsl (`nix/wsl` dir)
