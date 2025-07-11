{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixVersions.latest;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=$HOME/dots/nix/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  users.users.void = {
    isNormalUser = true;
    hashedPasswordFile = "../ingredients/system/env";
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [ 
      "dialout" "adbusers" "audio" "corectrl" "disk" 
      "input" "lp" "mongodb" "mysql" "network" "networkmanager" 
      "postgres" "power" "scanner" "sound" "systemd-journal" 
      "users" "video" "wheel" 
      "podman" "docker" "kvm" "libvirtd" "vboxusers"
    ];
  };
  programs.zsh.enable = true;
}
