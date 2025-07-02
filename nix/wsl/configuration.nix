{config, lib, pkgs, ...}:

{
  imports = [
    <nixos-wsl/modules>
    ./apps.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "void";

  system.stateVersion = "24.11";
}
