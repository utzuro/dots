{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs
    go rustup
    php

    (python3.withPackages (python-pkgs: [
      python-pkgs.pip
    ]))

    # tools
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
  ];
}
