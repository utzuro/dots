{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    kdePackages.qt6ct
    nautilus
  ]);
}
