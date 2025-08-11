{ pkgs, ... }:

{
  programs = {
    foot.enable = true; # still keeps foot around
    kitty = {
      enable = true;
      settings = {
        # Reduce the delay before repainting (in ms) — 5 ms ~ 200 fps possible
        repaint_delay = 5;

        # No input delay — keypresses are sent immediately
        input_delay = 0;

        # Try to sync drawing to the monitor refresh rate for smoothness
        sync_to_monitor = "yes";

        # Enable native Wayland if available (avoids Xwayland 60 Hz cap)
        enable_wayland = "yes";

        # Make sure scrollback updates are smooth
        scrollback_lines = 10000;

        # Optional: font hinting can affect perceived smoothness
        # disable_ligatures = "always";
        # adjust_line_height = 0;
      };
    };
  };
}

