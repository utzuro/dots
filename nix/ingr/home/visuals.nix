{ pkgs, inputs, ...}:

{
  imports = [
    inputs.hyprlux.homeManagerModules.default
  ];
  
  programs.hyprlux = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    night_light = {
      enabled = true;
      start_time = "21:00";
      end_time = "06:00";
    };

    vibrance_configs = [
      {
        window_class = "steam_app_1172470";
        window_title = "Apex Legends";
        strength = 100;
      }
      {
        window_class = "cs2";
        window_title = "";
        strength = 100;
      }
    ];
  };
}
