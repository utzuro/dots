{ pkgs, ...}:

{

  environment.systemPackages = with pkgs; [

    # tools
    xc

    # go
    go gopls gotags #gomod2nix
    gofumpt golangci-lint
    sqlc delve buf
    vips protobuf

    # rust
    rustup
    cargo-edit cargo-watch

    # python
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip setuptools wheel
      ]))
    uv nox

    # c/c++
    cmake llvm clang clang-tools
    ninja gnumake gdb
    ccls ctags

    # ruby
    ruby

    # functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    # web
    nodejs yarn php
    typescript typescript-language-server eslint

    # other
    lua dart ghostscript

    # network
    gource

    # devops
    tenv age 
    kind kubectx kubectl
    graphviz
    minio-client awscli2 awsebcli
    natscli
    lnav
    postman
    
    # AI
    ollama claude-code #openvino

    # DB
    sqlite postgresql redis pgcli 

    # hardware
    avrdude

    # system
    diffutils findutils
    patchelf

    # embedded
    screen minicom picocom tio bmaptool

  ];

}
