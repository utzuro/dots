{ pkgs, ...}:

{
  home.packages = with pkgs; [

    signal-desktop 
    discord vesktop
    telegram-desktop

    #element-desktop fractal
    # threema-desktop

    slack slack-term
    matterbridge matterircd
    # matterhorn # broken
    mattermostLatest mattermost-desktop

    zoom-us

  ];
}
