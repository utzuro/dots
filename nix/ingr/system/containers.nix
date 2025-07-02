{ pkgs, lib, storageDriver ? null, ...}:

assert lib.asserts.assertOneOf "storageDriver" storageDriver
[
  null "aufs" "btrfs" "devicemapper"
  "overlay" "overlay2" "zfs"
];

{

  virtualisation = {

    containers.enable = true;

    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   autoPrune.enable = true;
    # };

    docker = {
      enable = true;
      enableOnBoot = true;
      storageDriver = storageDriver;
      autoPrune.enable = true;
    };

  };

  environment.systemPackages = with pkgs; [
    kubernetes minikube kubectl 
    kubernetes-helm kompose
    # podman-compose 
    docker docker-compose compose2nix lazydocker
  ];

}

