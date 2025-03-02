{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    nautilus
    qt6.full
  ]);
}
