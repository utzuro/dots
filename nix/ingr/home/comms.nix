{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    element-desktop fractal
    # threema-desktop
    slack slack-term
    signal-desktop 
    discord vesktop
    telegram-desktop
    zoom-us
  ];
}
