{ pkgs, system, plugins, ... }:

let
  pluginList = [

    # ai
    "com.github.copilot"
    "dev.turingcomplete.intellijdevelopertoolsplugins"
    # "com.intellij.ml.llm"
    "org.jetbrains.junie"

    # tools
    "IdeaVIM"
    "org.jetbrains.IdeaVim-EasyMotion"
    "AceJump"
    "Docker"
    "org.intellij.plugins.hcl"
    "com.intellij.kubernetes"
    "com.intellij.ideolog"
    "idea.plugin.protoeditor"
    "com.intellij.lang.jsgraphql"

    # cloud intergrations
    "org.jetbrains.plugins.github"
    "org.jetbrains.plugins.gitlab"

    # extra langs
    "com.perl5"
    "org.toml.lang"
    "org.jetbrains.erlang"
    "mobi.hsz.idea.gitignore"
    "name.kropp.intellij.makefile"
    # "org.intellij.plugins.markdown"
    "com.jetbrains.plugins.ini4idea"
    "net.seesharpsoft.intellij.plugins.csv"
    "org.asciidoctor.intellij.asciidoc"
    "dev.meanmail.plugin.nginx-intellij-plugin"

    # frontend
    "NodeJS"
    # "org.intellij.plugins.postcss"
    # "org.intellij.css"
    # "org.jetbrains.plugins.vue"

    # Theme
    "yogi-amoled"
  ];

in
{


  environment.systemPackages = with pkgs; with plugins.lib."${system.arch}"; [
    jetbrains.jdk

    vscode
    android-studio
    jetbrains.writerside

    (buildIdeWithPlugins jetbrains "idea-ultimate" pluginList)
    (buildIdeWithPlugins jetbrains "goland" pluginList)
    (buildIdeWithPlugins jetbrains "pycharm-professional" pluginList)
    (buildIdeWithPlugins jetbrains "clion" pluginList)
    (buildIdeWithPlugins jetbrains "rust-rover" pluginList)
    (buildIdeWithPlugins jetbrains "rider" pluginList)
    (buildIdeWithPlugins jetbrains "ruby-mine" pluginList)
    (buildIdeWithPlugins jetbrains "webstorm" pluginList)
    (buildIdeWithPlugins jetbrains "datagrip" pluginList)
    # (buildIdeWithPlugins jetbrains "dataspell" pluginList)
    # (buildIdeWithPlugins jetbrains "aqua" pluginList)
  ];

}
