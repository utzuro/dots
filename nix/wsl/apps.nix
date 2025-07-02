{pkgs, ...}:

{
  environment.systemPackages = with pkgs;
  [

    # CLI

    ## shell
    git vim neovim emacs-pgtk
    ranger yazi vifm-full 
    ack ripgrep ripgrep-all fzf fd duf
    peco progress jq moreutils
    bat eza rsync
    wget curl 
    glow

    ## archives
    unzip zip gzip xz atool zstd lz4 lzip lzo lzop rar unar p7zip 

    ## tools
    file openssh coreutils
    goread 
    asciidoctor pandoc pdftk w3m
    pdftk qpdf poppler-utils ocrmypdf
    imagemagick ffmpeg aaxtomp3 mkvtoolnix
    taskwarrior3 
    ledger bc libqalculate bc numbat #cava 
    htop iotop ddgr bottom hwinfo pciutils psmisc

    #-------------------------------------------------

    # DEV

    ## tools
    xc

    ## go
    go gopls gotags #gomod2nix
    gofumpt golangci-lint
    sqlc delve buf
    vips

    ## ruby
    ruby

    ## rust
    rustup
    cargo-edit cargo-watch

    ## python
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip setuptools wheel
      ]))
    uv nox

    ## c/c++
    cmake clang clang-tools llvm 
    ninja gnumake gdb
    ccls ctags
    meson ninja

    ## functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    ## web
    nodejs yarn php
    typescript typescript-language-server eslint

    ## other
    lua dart ghostscript

    ## network
    gource

    ## devops
    tenv age 
    kind kubectx kubectl
    graphviz
    minio-client awscli2 awsebcli
    natscli
    lnav
    postman
    
   ## AI
    ollama claude-code openvino

    ## DB
    sqlite postgresql redis pgcli 

    ## system
    diffutils findutils
    patchelf

    ## embedded
    screen minicom picocom tio bmaptool

    #-------------------------------------------------

    # GUI

    ## network
    librewolf qutebrowser qbittorrent

    ## comms
    discord slack
    mattermost-desktop
    zoom-us

    ## media
    zathura calibre
    anki
    obs-studio
    vlc mpv kew
    libreoffice-fresh
    obsidian    # cli
    feh
    yt-dlp pipe-viewer
    tuir mediainfo 

    ## pkgs
    flatpak

    ## transfer
    filezilla libfilezilla
  ];

  # Required to work for apps like vscode
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; 
    ## If needed, you can add missing libraries here. nix-index-database is your friend to
    ## find the name of the package from the error message:
    ## https://github.com/nix-community/nix-index-database
    # libraries = options.programs.ni
  };
}
