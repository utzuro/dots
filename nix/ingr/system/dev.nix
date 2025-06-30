{ pkgs, system, plugins, ... }:
let
  pluginList = [
    "com.github.copilot"
    "dev.turingcomplete.intellijdevelopertoolsplugins"
    "com.intellij.ml.llm"
    # "org.jetbrains.junie"
    "IdeaVIM"
    "mobi.hsz.idea.gitignore"

    "Dart"
    "io.flutter"
  ];
in {
  environment.systemPackages = with pkgs; with plugins.lib."${system.arch}"; [
    jetbrains.gateway jetbrains.jdk
    (buildIdeWithPlugins jetbrains "idea-ultimate" pluginList)
    (buildIdeWithPlugins jetbrains "goland" pluginList)
    (buildIdeWithPlugins jetbrains "pycharm-professional" pluginList)
    (buildIdeWithPlugins jetbrains "clion" pluginList)
    (buildIdeWithPlugins jetbrains "rust-rover" pluginList)
    (buildIdeWithPlugins jetbrains "rider" pluginList)
    (buildIdeWithPlugins jetbrains "ruby-mine" pluginList)
    (buildIdeWithPlugins jetbrains "webstorm" pluginList)
    (buildIdeWithPlugins jetbrains "mps" pluginList)
    (buildIdeWithPlugins jetbrains "datagrip" pluginList)
    (buildIdeWithPlugins jetbrains "dataspell" pluginList)
    (buildIdeWithPlugins jetbrains "aqua" pluginList)
    # (buildIdeWithPlugins "android-studio" pluginList)

    #vscode #android-studio #writerside
  ];
}
