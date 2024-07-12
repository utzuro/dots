{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    # threema-desktop
    signal-desktop 
    signald signaldctl signal-cli
    webcord discord telegram-desktop
    protonmail-desktop
  ];
}
