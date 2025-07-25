{ pkgs, ... }:

{
  xdg.enable = true;
  home.packages = with pkgs; [
    arandr
  ];
}
