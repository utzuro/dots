{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs
    ghc
    go rustup
    php nodejs
    cmake clang clang-tools ctags llvm boost ccache

    nixpkgs-fmt nil

    (python3.withPackages (python-pkgs: [
      python-pkgs.pip
    ]))

    # tools
    zed-editor
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    androidStudioPackages.dev
    flutter
  ];
}
