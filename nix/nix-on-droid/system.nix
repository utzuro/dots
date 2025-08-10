{ config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    vim
    git
    tmux
    openssh
    zsh
    busybox
    zip
    unzip
  ];

  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Asia/Tokyo";
}
