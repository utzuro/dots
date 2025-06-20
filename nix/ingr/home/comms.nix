{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # chats
    element-desktop fractal
    # threema-desktop
    slack slack-term
    matterbridge matterircd
    # matterhorn # broken
    mattermostLatest mattermost-desktop
    signal-desktop 
    discord vesktop
    telegram-desktop
    zoom-us
  ];
}
