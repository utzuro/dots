{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs ghc
    go rustup
    php nodejs

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        # ... python packages
      ]))

    # devops
    tenv

    # tools
    gopls sqlc ccls
    minio-client
    zed-editor patchelf
    vscode
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

    # DB
    dbeaver-bin pgmodeler sqlitebrowser
  ];
}
