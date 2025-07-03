{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    zsh zplug oh-my-zsh
    vim git tmux
    ranger
    rsync
    wget curl
    file
  ];

}
