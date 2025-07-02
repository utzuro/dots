{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vim git tmux
    ranger
    rsync
    wget curl
    file
  ];

}
