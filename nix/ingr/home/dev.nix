{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs ghc
    go rustup
    php nodejs

    nixpkgs-fmt nil

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [ ]))

    ocaml dune_3

    # devops
    tenv

    # tools
    gopls sqlc ccls ctags gnumake #go-task (conflict with taskwarrior)
    minio-client
    zed-editor patchelf
    # vscode
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

    # AI
    ollama

    # DB
    dbeaver-bin pgmodeler sqlitebrowser

    # System API
    portaudio

    # Robotics
    # mblock-mlink
  ];
}
