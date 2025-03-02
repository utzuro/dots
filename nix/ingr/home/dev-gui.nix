{ pkgs, ...}:

{
  home.packages = with pkgs; [
    sqlitebrowser 
    dbeaver-bin pgmodeler 
    ghidra
    httpie altair
    portaudio

    # Robotics
    # mblock-mlink
    # ros2

    # IDE
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.goland ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-community ["github-copilot"])
    # (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])

