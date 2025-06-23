{ pkgs, system, plugins, ... }:
let
  pluginList = [
    plugins."${system.arch}".idea-ultimate."2025.3"."com.intellij.plugins.watcher"
  ];
in {
  environment.systemPackages = [
    # See "How to setup" for definition of `pluginList`.
    # pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate pluginList
  ];
}
  # environment.systemPackages = with pkgs; with plugins.lib."${system.arch}"; [
  # environment.systemPackages = with pkgs; [
  #   jetbrains.plugins.addPlugins jetbrains.idea-ultimate pluginList
    # buildIdeWithPlugins jetbrains "idea-ultimate" pluginList
    # buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" ["com.intellij.plugins.watcher"]
  # ];
# }

