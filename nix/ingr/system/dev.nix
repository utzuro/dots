{ pkgs, system, plugins, ... }:
let
  pluginList = [
    "com.intellij.plugins.watcher"
  ];
in {
  environment.systemPackages = with pkgs; with plugins.lib."${system.arch}"; [
    (buildIdeWithPlugins pkgs.jetbrains "idea-ultimate" pluginList)
  ];
}
