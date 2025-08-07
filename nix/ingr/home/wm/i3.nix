{ pkgs, ... }:

{
  imports = [
    ./x.nix
  ];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # theme = ~/dots/config/rofi/void.rasi;
    plugins = [ pkgs.rofi-calc ];
  };

  home.file.".config/i3/config".source = ~/dots/config/i3/config;

  home.packages = with pkgs; [
    arandr
  ];
}
