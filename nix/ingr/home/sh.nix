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

    # git
    upd = "git commit -am 'update && git push'";
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
    tmux zellij 
    ranger yazi vifm-full 
    ack ripgrep ripgrep-all fzf fd duf
    peco progress jq
    bat eza rsync
    wget curl 

    # archives
    unzip zip gzip xz atool zstd lz4 lzip lzo lzop p7zip rar rzip unar 

    # shells
    elvish xonsh

    # tools
    killall timer xdragon
    lfs lsd lsdvd ncdu file
    disfetch lolcat neofetch pfetch
    w3m asciidoctor pandoc pdftk foremost
    imagemagick ffmpeg aaxtomp3 
    htop ddgr bottom hwinfo pciutils psmisc
    cava bc numbat
    ledger bc
    inotify-tools pistol

    taskwarrior3 tasksh geek-life
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
