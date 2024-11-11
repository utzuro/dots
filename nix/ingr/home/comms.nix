{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    element-desktop fractal
    # threema-desktop
    signal-desktop 
    signald signaldctl signal-cli
    webcord discord vesktop
    telegram-desktop
    protonmail-desktop
    zoom-us
  ];
}
