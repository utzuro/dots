{ config, lib, pkgs, modulesPath, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
