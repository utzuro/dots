{ config, pkgs, user, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/dots/nix/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  users.users.${user.name} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "dialout" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      c = "clear";
      update = "sudo nixos-rebuild switch";
      conf = "sudo vim /etc/nixos/configuration.nix";
    };
  };
}
