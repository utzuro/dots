# make user name configurable
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
    uid = 1000;
    # Generate it with mkpasswd
    hashedPassword = "oAFZQrphDsb2c";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPBVZd4VBBztymo6sO0RxMPCLbswmOXJViK18Qs1c504"
    ];
    shell = pkgs.zsh;
    extraGroups = [
      "dialout"
      "adbusers"
      "audio"
      "corectrl"
      "disk"
      "input"
      "lp"
      "mongodb"
      "mysql"
      "network"
      "networkmanager"
      "postgres"
      "power"
      "scanner"
      "sound"
      "systemd-journal"
      "users"
      "video"
      "wheel"
      "podman"
      "docker"
      "kvm"
      "libvirtd"
      "vboxusers"
      "samba"
    ];
  };
  nix.settings.trusted-users = [ "void" "root" ];
  programs.zsh.enable = true;
}
