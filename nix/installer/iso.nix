# How to build:
# mkpasswd > ingr/system/lib/hashedPasswordFile # clean the file
# export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-unstable
#  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage 
{ lib, ... }:

let
  system = {
    arch = "x86_64-linux";
    host = "voidos";
  };
  user = {
    name = "void";
  };
in
{
  _module.args = { inherit user; inherit system; };
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    # Inject the same settings as main flake.nix uses
    ../ingr/system/boot.nix
    ../ingr/system/basic.nix
    ../ingr/system/dev.nix
    ../ingr/system/network/settings.nix
    ../ingr/system/virtualization.nix

    ../ingr/system/wm/all.nix

    ../ingr/system/power/pc.nix
    ../ingr/system/hardware/intel.nix
    ../ingr/system/hardware/storage.nix
    ../ingr/system/hardware/video.nix
    ../ingr/system/hardware/nvidia.nix

    ../ingr/system/hardware/nfs.nix

    ../ingr/system/games/gaming.nix
    ../ingr/system/games/steam.nix

    # temporary fixes, etc
    ../ingr/system/temp.nix
  ];

  services.journald.audit = false;
  security.audit.enable = lib.mkForce false;
  security.auditd.enable = false;

  # Fix conflict
  programs.command-not-found.enable = lib.mkForce true;

  nixpkgs.config.problems.handlers.zfs.broken = "warn";
}
