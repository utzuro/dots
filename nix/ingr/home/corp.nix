{ pkgs, ... }:

{

  imports = [
  ];

  home.packages = with pkgs; [
    jiratui
    go-jira
    jira-cli-go
  ];

}
