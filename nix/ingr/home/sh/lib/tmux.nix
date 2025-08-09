{ pkgs, ... }:

let
  resurrectDir = "/home/void/.tmux/resurrect";
  usr="void";
in {
  programs.tmux = {
    enable = true;
    prefix = "M-a";
    keyMode = "vi";
    clock24 = true;
    newSession = true;
    mouse = true;
    secureSocket = true;
    sensibleOnTop = true;
    # shell = "zsh";
    # enableFzf = true;
    terminal = "screen-256color";
    escapeTime = 0;
    extraConfig = ''
    set-option -g status-style bg=colour0,fg=white
    set-option -g status-left '#(shell-command)#[attributes]'
    set-option -g status-right '#[fg=colour140]#{session_name}'
    set-option -g window-status-current-format '#[bold]#(echo"<<")#{window_index}#(echo ":")#{window_name}'
    setw -g window-status-current-style fg=white,bg=colour140,bright
    set-option -g window-status-format '#[fg=colour140]#{window_index}#(echo ":")#{window_name}'
    '';
    plugins = with pkgs.tmuxPlugins; [
      cpu open fpp yank jump ctrlw copycat
      dracula logging sysstat urlview sysstat
      tmux-thumbs battery tmux-fzf extrakto fuzzback
      net-speed sessionist prefix-highlight maildir-counter
      better-mouse-mode vim-tmux-navigator vim-tmux-focus-events

      {
        plugin = resurrect;
        extraConfig = ''
        set -g @resurrect-strategy-vim 'session'
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-processes '"~nvim"'
        set -g @resurrect-capture-pane-contents 'on'
        set -g @resurrect-dir ${resurrectDir}
        '';
      } 

      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15' # minutes
        '';
      }

    ];
  };
}
