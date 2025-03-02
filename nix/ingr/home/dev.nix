{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # dev

    ## go
    go gopls gotags 
    gofumpt golangci-lint
    sqlc delve

    ## rust
    rustup cargo 
    cargo-edit cargo-watch

    ## python
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip setuptools wheel
      ]))
    uv nox

    # c/c++
    cmake clang gcc clang-tools llvm 
    ninja gnumake gdb
    ccls ctags

    ## functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    ## other
    php nodejs lua luajit dart

    # devops
    tenv opentofu
    ghidra
    age

    # tools
    minio-client
    gh gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot gh2md
    

    # IDE
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

    # AI
    ollama

    # DB
    sqlite postgresql dragonflydb
    pg-cli pgvector 
    dbeaver-bin pgmodeler 
    sqlitebrowser 

    # API
    httpie altair
    awscli2

    # System API
    portaudio

    # Robotics
    # mblock-mlink
    # ros2
  ];

}
