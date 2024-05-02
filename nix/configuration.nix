# install and update with 
# `sudo nixos-rebuild switch --flake .#system --impure`

{ config, lib, pkgs, user, inputs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      ./ingredients/system/system.nix
      ./ingredients/system/wm/fonts.nix
      ./ingredients/system/wm/i3.nix
      ./ingredients/system/wm/hyprland.nix
      ./ingredients/system/video.nix
      ./ingredients/system/gaming.nix
      ./ingredients/system/storage.nix
      ./ingredients/system/network.nix
      ./ingredients/system/security.nix
      ( import ./ingredients/system/virtualization.nix {
        storageDriver = "btrfs"; inherit pkgs user lib;
      })
      ./ingredients/theme.nix
    ];

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/dots/nix/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  nixpkgs.config.allowUnfree = true;

  users.users.void = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "dialout" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  # zsh env is defined with home-manager
  # but I keep some configs here for the root too
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      c = "clear";
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      conf = "sudo vim /etc/nixos/configuration.nix";
    };
  };

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
  xdg.mime.enable = true;

  system.copySystemConfiguration = false;
  system.stateVersion = "23.11";
}
