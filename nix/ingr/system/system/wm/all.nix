{ pkgs, ...}:

{
  impports = [
    ./gnome.nix
    ./kde.nix
    ./i3.nix
    ./sway.nix
    ./hyprland.nix
  ];

}
