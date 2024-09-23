{ pkgs, lib, storageDriver ? null, ...}:

assert lib.asserts.assertOneOf "storageDriver" storageDriver
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

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };

  # virtualisation.waydroid.enable = true;
  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   storageDriver = storageDriver;
  #   autoPrune.enable = true;
  # };
  environment.systemPackages = with pkgs; [
    # docker docker-compose compose2nix lazydocker
    podman-compose
    virtualbox
  ];
}
