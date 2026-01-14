{ pkgs, ... }:

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
      storageDriver = "overlay2";
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

