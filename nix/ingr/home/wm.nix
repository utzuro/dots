{ pkgs, ...}:

{

  imports = [
      # ./wm/hyprland.nix
      ./wm/i3.nix
      ./wm/X.nix
    ];

}
