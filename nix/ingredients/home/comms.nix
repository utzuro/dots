{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    # threema-desktop
    signal-desktop 
    signald signaldctl signal-cli
    webcord discord vesktop
    telegram-desktop
    protonmail-desktop
    zoom-us
  ];
}
