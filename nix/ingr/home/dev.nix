{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs ghc
    go rustup
    php nodejs

    nixpkgs-fmt nil

    python3 uv 
    # (pkgs.python3.withPackages (
    #   python-pkgs: with python-pkgs; [ ]))

    ocaml dune_3

    # devops
    tenv ghidra

    # tools
    gopls sqlc ccls ctags gotags gnumake #go-task (conflict with taskwarrior)
    minio-client
    gh gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

    # AI
    ollama

    # DB
    dbeaver-bin pgmodeler sqlitebrowser

    # API
    httpie altair
    awscli2

    # System API
    portaudio

    # Robotics
    # mblock-mlink
  ];
}
