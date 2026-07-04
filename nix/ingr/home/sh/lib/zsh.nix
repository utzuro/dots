{ user, ... }:

let
  aliases = import ./aliases.nix { inherit user; };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases.core // aliases.zshExtra;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "git"
        "gitignore"
        "colored-man-pages"
        "command-not-found"
        "history"
        "pip"
        "zsh-interactive-cd"
        "web-search"
        "z"
      ];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        }
      ];
    };

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      HYPHEN_INSENSITIVE="true"
      ENABLE_CORRECTION="true"

      # Plugin configs
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
      bindkey '[A' history-substring-search-up
      bindkey '[B' history-substring-search-down

      # Shell options
      set -o vi
      typeset -U path PATH
      path=(~/alchemy/scripts ~/alchemy/scripts/**/*(/N) $path)
      export fpath=(~/.zsh/completion $fpath)
    '';
  };
}
