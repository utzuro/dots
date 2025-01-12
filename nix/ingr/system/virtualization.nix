{ pkgs, lib, storageDriver ? null, ...}:

assert lib.asserts.assertOneOf "storageDriver" storageDriver
[
  null "aufs" "btrfs" "devicemapper"
  "overlay" "overlay2" "zfs"
];

{

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
    };
  };

  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [
    podman-compose virtualbox
    kubernetes minikube kubectl 
    kubernetes-helm kompose
  ];

}



## Depricated
  # No need to use docker, podman is better
  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   storageDriver = storageDriver;
  #   autoPrune.enable = true;
  # };

  # environment.systemPackages = with pkgs; [
    # docker docker-compose compose2nix lazydocker
  # ];
