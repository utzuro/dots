{ ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = ./themes/void.rasi;
    plugins = [ pkgs.rofi-calc ];
  };

  home.file.".config/i3/config".source = ../i3/config;
}
