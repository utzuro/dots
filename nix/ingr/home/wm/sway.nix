{ ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemd.variables = [ "--all" ];
    input."*".xkb_layout = "en";
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        { command = "firefox"; }
      ];
    };
  };

}
