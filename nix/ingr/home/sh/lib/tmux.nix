{ pkgs, ... }:

let
  resurrectDir = "/home/void/.tmux/resurrect";
  usr = "void";
in
{
  programs.tmux = {
    enable = true;
    # prefix = "C-a";
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
      set-option -g status-style bg=colour0,fg=colour141
      set -g status-interval 2
      set -g status-right-length 150
      set -g status-left-length 40

      # LEFT
      set-option -g status-left '#(shell-command)'
      set-option -g window-status-current-format '#[bold]#(echo"<<")#{window_index}#(echo ":")#{window_name}'
      setw -g window-status-current-style fg=white,bg=colour141,bright
      set-option -g window-status-format '#[fg=colour141]#{window_index}#(echo ":")#{window_name}'

      # RIGHT
      set -g @sysstat_mem_view_tmpl '#{mem.pused}'
      set -g @sysstat_mem_size_unit 'G'

      set -g @cpu_percentage_format '%.0f%%'
      set -g @download_speed_format '%s'
      set -g @upload_speed_format '%s'

      set -g status-right ' #{cpu_percentage}  #{sysstat_mem} 󰚥 #(cut -d" " -f1 /proc/loadavg)   #{battery_percentage} #{battery_remain} %H:%M:%S'

      # Navigation
      set -g @vim_navigator_pattern '(\S+/)?g?\.?(view|l?n?vim?x?|fzf|nvr|lvim|nvim-qt|neovide)(diff)?(-wrapped)?'

      # --- run plugin scripts AFTER setting status so tokens get expanded ---
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      run-shell ${pkgs.tmuxPlugins.sysstat}/share/tmux-plugins/sysstat/sysstat.tmux
      run-shell ${pkgs.tmuxPlugins.net-speed}/share/tmux-plugins/net-speed/net_speed.tmux
      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/vim-tmux-navigator/vim-tmux-navigator.tmux

    '';
    plugins = with pkgs.tmuxPlugins; [
      cpu
      open
      fpp
      yank
      jump
      ctrlw
      copycat
      dracula
      logging
      sysstat
      urlview
      sysstat
      tmux-thumbs
      battery
      tmux-fzf
      extrakto
      fuzzback
      net-speed
      sessionist
      prefix-highlight
      maildir-counter
      better-mouse-mode
      vim-tmux-navigator
      vim-tmux-focus-events

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
