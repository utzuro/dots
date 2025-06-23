{ pkgs, ...}:

let jet-plugins = [
  "github-copilot"
];
in {
  home.packages = with pkgs; with pkgs.jetbrains; [
    sqlitebrowser 
    dbeaver-bin pgmodeler 
    ghidra
    httpie altair
    portaudio

    # Robotics
    # mblock-mlink
    # ros2

    # IDE
    vscode android-studio

    # jetbrains-jdk-jcef
    # gateway
    # dataspell aqua writerside
    # clion datagrip goland pycharm-professional
    # rust-rover rider ruby-mine webstorm idea-ultimate mps
    # (plugins.addPlugins goland jet-plugins)
    # (plugins.addPlugins pycharm-professional jet-plugins)
    # (plugins.addPlugins clion jet-plugins)
    # (plugins.addPlugins rust-rover jet-plugins)
    # (plugins.addPlugins rider jet-plugins)
    # (plugins.addPlugins ruby-mine jet-plugins)
    # (plugins.addPlugins webstorm jet-plugins)
    # (plugins.addPlugins idea-ultimate jet-plugins)
    # (plugins.addPlugins mps jet-plugins)
    # extra
    # (plugins.addPlugins datagrip jet-plugins)
  ];

}
