# how to build:
# export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-25.05
#  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage 
{ pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

    # Inject the same settings as main flake.nix uses
    ../ingr/system/basic.nix
    # ../ingr/system/dev.nix
    # ../ingr/system/virtualization.nix

    # ../ingr/system/wm/all.nix

    # ../ingr/system/power/pc.nix
    # ../ingr/system/hardware/intel.nix
    # ../ingr/system/hardware/video.nix
    # ../ingr/system/hardware/nvidia.nix

    # ../ingr/system/games/gaming.nix
    # ../ingr/system/games/steam.nix
  ];

  networking.hostName = "VoidOS";
  services.openssh.enable = true;
  # services.resolved.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

}
