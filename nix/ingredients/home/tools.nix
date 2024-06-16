{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tesseract
    syncthing syncthingtray
  ];
}
