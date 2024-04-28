{ pkgs, ... }:
let
  aliases = {
    c = "clear";
    vim = "nvim";
    less = "nvimpager";
    cat = "nvimpager";

    # git
    upd = 'git commit -am "update"';
    push = 'git push';
    pull = 'git pull --ff-only';

    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    ino = arduino-cli;
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";
  };
in
{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;
  };

  home.packages = with pkgs; [
    vim neovim nvimpager 
    git onefetch
    disfetch lolcat
    ack fd bat
    asciidoctor
    bottom
    bc
  ];
}
