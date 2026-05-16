{ pkgs, lib, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "openclaw-2026.5.7"
  ];

  environment.systemPackages = with pkgs; [
    zsh
    neovim
    tmux
    jq
    curl
    wget
    htop
    git
    ripgrep
    openclaw
  ];
}
