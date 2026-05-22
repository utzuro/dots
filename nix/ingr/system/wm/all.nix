{ ... }:

{
  # Intentionally enables all system-level desktop/session modules for
  # workstation profiles that should expose multiple login sessions.
  imports = [
    ./gnome.nix
    ./kde.nix
    ./i3.nix
    ./sway.nix
    ./hyprland.nix
  ];
}
