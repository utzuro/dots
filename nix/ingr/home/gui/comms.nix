{ pkgs, ... }:
{
  home.packages = with pkgs; [
    telegram-desktop
    signal-desktop
    #discord broken
    vesktop
  ];
}
