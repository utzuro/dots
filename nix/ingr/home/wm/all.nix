{ pkgs, ...}:

{

  imports = [
      ./gnome.nix
      ./hyprland.nix
      ./i3.nix
    ];

}
