{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    element-desktop fractal
    # threema-desktop
    slack slack-cli slack-term
    signal-desktop 
    signald signaldctl signal-cli
    discord vesktop
    telegram-desktop
    zoom-us
  ];
}
