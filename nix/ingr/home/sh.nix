{ pkgs, lib, ... }:

let
  aliases = {
    c = "clear";
    vim = "nvim";
    ls = "eza";
    tree = "eza --tree";
    cat = "bat";
    todo = "vim ~/todo";
    mpv = "mpv --alang=jpn";
    yt = "yt-dlp";

    # git
    upd = "git commit -am 'update' && git push";
    push = "git push";
    pull = "git pull --ff-only";
    rebase = "git pull --rebase";
    force = "git push --force";
    amend = "git commit --amend";

    # apps
    pv = "pipe-viewer";
    m = "myougiden";
    t = "tango";
    ron = "redshift -P -O 3200 -b1";
    roff = "redshift -P -O 6200 -b1";
    ino = "arduino-cli";
    real = "ledger -f $LEDGER bal Assets --real";
    budgets = "ledger -f $LEDGER bal Budget";

    # run apps from terminal
    ## dev
    k8s = "kubectl";
    clion = "nohup clion >/dev/null 2>&1 &";
    goland = "nohup goland >/dev/null 2>&1 &";
    pycharm = "nohup pycharm-community >/dev/null 2>&1 &";
    ## browsers
    chrome = "nohup chromium >/dev/null 2>&1 &";
    libre = "nohup librewolf >/dev/null 2>&1 &";
    firefox = "nohup firefox >/dev/null 2>&1 &";

    MY_HOMEMANAGER = "~/alchemy/summons/nixos/home-manager";
    build-my-home = "./ingr/cleanup && home-manager switch --flake .#void --override-input home-manager ~/alchemy/summons/nixos/home-manager --impure";

    XDG_DESKTOP_DIR = "$HOME/";
    XDG_DOWNLOAD_DIR = "$HOME/channeling";
    XDG_TEMPLATES_DIR = "$HOME/magic";
    XDG_PUBLICSHARE_DIR = "$HOME/magic";
    XDG_DOCUMENTS_DIR = "$HOME/magic";
    XDG_MUSIC_DIR = "$HOME/magic";
    XDG_PICTURES_DIR = "$HOME/magic";
    XDG_VIDEOS_DIR = "$HOME/magic";
  };
in {
  home.packages = with pkgs; [
    vim neovim
    ranger yazi vifm-full 
    ack ripgrep ripgrep-all fzf fd duf
    peco progress jq
    bat eza rsync
    wget curl 

    # archives
    unzip zip gzip xz atool zstd lz4 lzip lzo lzop rar rzip unar #p7zip 

    # tools
    killall timer xdragon
    lfs lsd lsdvd ncdu file
    disfetch lolcat neofetch pfetch
    w3m asciidoctor pandoc pdftk foremost
    imagemagick ffmpeg aaxtomp3 
    htop ddgr bottom hwinfo pciutils psmisc
    cava bc numbat
    ledger bc libqalculate
    inotify-tools pistol

    taskwarrior3
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" "gitignore" 
        "colored-man-pages" 
        "command-not-found" 
        "history" 
        "pip" 
        "docker" 
        "zsh-interactive-cd" 
        "web-search" 
        "z" 
      ];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
   };

   initExtra = ''
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
    export fpath=(~/.zsh/completion $fpath)
   '';
  };

  programs.tmux = {
    enable = true;
    prefix = "M-a";
    keyMode = "vi";
    clock24 = true;
    newSession = true;
    mouse = true;
    secureSocket = true;
    sensibleOnTop = true;
    escapeTime = 0;
    extraConfig = ''
    set-option -g status-style bg=colour0,fg=white
    set-option -g status-left '#(shell-command)#[attributes]'
    set-option -g status-right '#[fg=colour140]#{session_name}'
    set-option -g window-status-current-format '#[bold]#(echo"<<")#{window_index}#(echo ":")#{window_name}'
    setw -g window-status-current-style fg=white,bg=colour140,bright
    set-option -g window-status-format '#[fg=colour140]#{window_index}#(echo ":")#{window_name}'
    '';
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.open
      tmuxPlugins.fpp
      tmuxPlugins.yank
      tmuxPlugins.jump
      tmuxPlugins.ctrlw
      tmuxPlugins.copycat
      tmuxPlugins.dracula
      tmuxPlugins.logging
      tmuxPlugins.sysstat
      tmuxPlugins.urlview
      tmuxPlugins.sysstat
      tmuxPlugins.tmux-thumbs
      tmuxPlugins.battery
      tmuxPlugins.tmux-fzf
      tmuxPlugins.extrakto
      tmuxPlugins.fuzzback
      tmuxPlugins.net-speed
      tmuxPlugins.sessionist
      tmuxPlugins.prefix-highlight
      tmuxPlugins.maildir-counter
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.vim-tmux-focus-events
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };

  xdg.configFile."lf/icons".source = ./i/icons;
  programs.lf = {
    enable = true;

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
      '';
    };

    keybindings = {
      c = "mkdir";
      "." = "set hidden!";

      "<enter>" = "open";
      o = "open";
      do = "dragon-out";
      ee = "editor-open";
      V = ''''$${pkgs.bat}/bin/bat --paging=always "$f"'';

      "g" = "cd";
      "gh" = "cd ~";
      "g/" = "cd /";

      "x" = "cut";
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = 
    let
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5
        
        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';

    in ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
