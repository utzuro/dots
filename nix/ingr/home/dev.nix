{ pkgs, ...}:

{
  home.packages = with pkgs; [

    # dev

    ## go
    go gopls gotags 
    gofumpt golangci-lint
    sqlc delve

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

    ## functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    ## other
    php nodejs lua dart

    # devops
    tenv age

    # tools
    minio-client awscli2
    gh gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot gh2md
    
    # AI
    ollama

    # DB
    sqlite postgresql redis
    pgcli 
  ];

}
