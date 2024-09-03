{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs ghc
    go rustup
    php nodejs
    cmake clang clang-tools ctags ccls llvm boost ccache
    rPackages.pkgconfig


    nixpkgs-fmt nil

    (python3.withPackages (python-pkgs: [
      python-pkgs.pip
    ]))

    # tools
    zed-editor patchelf
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])
    androidStudioPackages.dev
    flutter

    # DB
    dbeaver-bin pgmodeler sqlitebrowser
  ];
}
