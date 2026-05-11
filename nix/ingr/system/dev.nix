{ pkgs, ... }:

{
  imports =
    [
      ./lib/containers.nix
      # ./lib/android.nix
    ];

  services.flatpak.enable = true;
}

