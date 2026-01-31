{ pkgs, dirs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # theme = dirs.config + /rofi/void.rasi;
    plugins = [ pkgs.rofi-calc ];
  };

  home.file.".config/i3/config".source = dirs.config + /i3/config;

  home.packages = with pkgs; [
    arandr
  ];
}
