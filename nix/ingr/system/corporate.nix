{ pkgs, ...}:

{
    services.intune.enable = true;

    environment.systemPackages = with pkgs; [

    intune-portal

    slack slack-term
    matterbridge matterircd
    # matterhorn # broken
    mattermostLatest mattermost-desktop

    zoom-us

  ];

}
