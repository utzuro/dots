{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # langs
    go rustup python3
    php nodejs_21 

    # tools
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])
  ];
}
