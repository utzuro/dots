{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
    neovide zathura
  ];
}
