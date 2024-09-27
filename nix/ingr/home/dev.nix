{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs ghc
    go rustup
    php nodejs

    # tools
    gopls
    minio-client
    zed-editor patchelf
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

    # DB
    dbeaver-bin pgmodeler sqlitebrowser
  ];
}
