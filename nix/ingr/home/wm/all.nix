{ ... }:

{
  # Intentionally enables all user-session window manager integrations so each
  # session is available from display managers on workstation profiles.
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./i3.nix
    ./sway.nix
  ];
}
