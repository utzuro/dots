{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # dev

    ## go
    go gopls gotags
    sqlc 

    ## rust
    rustup

    ## python
    python3 uv 
    # (pkgs.python3.withPackages (
    #   python-pkgs: with python-pkgs; [ ]))

    # c/c++
    cmake clang clang-tools llvm 
    ninja gnumake
    ccls ctags

    ## functional
    nixpkgs-fmt nil
    ocaml dune_3

    ## other
    php nodejs lua luajit dart

    # devops
    tenv ghidra

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
    sqlite postgresql
    pg-cll
    dbeaver-bin pgmodeler 
    sqlitebrowser 

    # API
    httpie altair
    awscli2

    # System API
    portaudio

    # Robotics
    # mblock-mlink
  ];
}
