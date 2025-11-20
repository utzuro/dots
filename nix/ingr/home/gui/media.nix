{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hakuneko
    libreoffice-qt6-fresh
    anki
    zathura
  ];
}
