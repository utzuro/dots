{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    signal-desktop
    signald
    signaldctl
    signal-cli
    webcord
    telegram-desktop
  ];
}
