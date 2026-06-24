# Utzuro's configs

Here are my configs, mainly for NixOS and tools like vim, but also for other things.
Some of the configs are applicable to Windows or macOS, but mostly Arch Linux and NixOS.

OS agnostic configs are saved in config directory and they get semilinked (copied on win) by running bootstrap.sh which runs packages/shell.sh.

Nix configs are in nix directory where flake.nix is main entry point which imports nix/ingr/home for home-manager related packages and configs and nix/ingr/system for systemwide.

Settings made for NixOS but most of them are also used by wsl (`nix/wsl` dir)
