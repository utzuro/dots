# how to build:
# export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-25.05
#  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage 
{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo.wheelNeedsPassword = false;
  users.users.void = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBVZd4VBBztymo6sO0RxMPCLbswmOXJViK18Qs1c504"
      # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5key"
    ];

    isNormalUser = true;
    description = "Lord of Chaos";
    extraGroups = [ "wheel audio video" ];
    initialPassword = "tmp"; # random for this post
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
    git
    rsync
    yazi
    eza
    zsh
    vim
    wget
    curl
    rxvt-unicode # for terminfo
    lshw
  ];

  programs.zsh.enable = true;
  services.openssh.enable = true;

  system.stateVersion = "25.05";

}
