{ pkgs, lib, system ? null, ... }:

assert lib.asserts.assertOneOf "storageDriver" system.storageDriver
  [
    null
    "aufs"
    "btrfs"
    "devicemapper"
    "overlay"
    "overlay2"
    "zfs"
  ];

{

  virtualisation = {

    containers.enable = true;

    # Had some troubles with podman, so fallback to docker for now
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   autoPrune.enable = true;
    # };

    docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = system.storageDriver;
      autoPrune.enable = true;
    };

  };

  environment.systemPackages = with pkgs; [
    kubernetes
    minikube
    kubectl
    kubernetes-helm
    kompose
    # podman-compose 
    docker
    docker-compose
    compose2nix
    lazydocker
  ];

}

