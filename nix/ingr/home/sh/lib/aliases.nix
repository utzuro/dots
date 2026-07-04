# Single source of truth for shell aliases.

{ user }:

{
  core = {
    c = "clear";
    vim = "nvim";
    v = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    wget = "wget2";
    todo = "nvim ~/todo";
    mpv = "mpv --alang=jpn";
    yt = "yt-dlp --no-playlist";
    ytp = "yt-dlp -f 'bv*[height<=2160]+ba/b' --cookies-from-browser firefox";

    # git
    com = "git commit";
    push = "git push";
    pull = "git pull --ff-only";
    pul = "git pull --ff-only";
    pl = "git pull --ff-only";
    rebase = "git pull --rebase";
    force = "git push --force-with-lease";
    forc = "git push --force-with-lease";
    amend = "git commit --amend";
    diff = "git diff --color-words";
    cached = "git diff --cached --color-words";
    changes = "git diff main --color-words";
    chmain = "git diff main --name-only";
    chmaster = "git diff master --name-only";
    chdev = "git diff dev --name-only";

    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ino = "arduino-cli";
    k8s = "kubectl";
  };

  zshExtra = {
    k = "ps aux | fzf | awk '{print $2}' | xargs -r kill -9";

    # git quick commits
    upd = "git commit -am 'minor update' && git push";
    bump = "git commit -am 'version bump' && git push";
    refactor = "git commit -am 'refactor' && git push";
    hotfix = "git commit -am 'hotfix' && git push";
    addtests = "git commit -am 'add tests' && git push";

    # nix
    nsh = "nix develop --command zsh";
    snsh = "nix develop --impure --command secretspec run --profile development -- zsh";
    build-my-home = "$HOME/dots/nix/ingr/cleanup && home-manager switch --flake $HOME/dots#${user.name}";

    # apps
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";

    ## GUI launchers
    idea = "nohup idea-ultimate >/dev/null 2>&1 &";
    goland = "nohup goland >/dev/null 2>&1 &";
    pycharm = "nohup pycharm-professional >/dev/null 2>&1 &";
    clion = "nohup clion >/dev/null 2>&1 &";
    rustrover = "nohup rust-rover >/dev/null 2>&1 &";
    rubymine = "nohup ruby-mine >/dev/null 2>&1 &";
    rider = "nohup rider >/dev/null 2>&1 &";
    webstorm = "nohup webstorm >/dev/null 2>&1 &";
    datagrip = "nohup datagrip >/dev/null 2>&1 &";
    studio = "nohup android-studio >/dev/null 2>&1 &";
    code = "nohup code >/dev/null 2>&1 &";
    dbeaver = "nohup dbeaver >/dev/null 2>&1 &";
    postman = "nohup postman >/dev/null 2>&1 &";
    notion = "nohup notion-app >/dev/null 2>&1 &";

    ## browsers
    chrome = "nohup chromium >/dev/null 2>&1 &";
    libre = "nohup librewolf >/dev/null 2>&1 &";
    firefox = "nohup firefox >/dev/null 2>&1 &";

    # system
    open-port = "while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.2.0.1 && natpmpc -a 1 0 tcp 60 -g 10.2.0.1 || { echo -e 'ERROR' ; break ; } ; sleep 45 ; done";
  };
}
