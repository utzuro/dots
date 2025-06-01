{ pkgs, lib, storageDriver ? null, ...}:

assert lib.asserts.assertOneOf "storageDriver" storageDriver
[
  null "aufs" "btrfs" "devicemapper"
  "overlay" "overlay2" "zfs"
];

{

  boot.binfmt.emulatedSystems = [
    "aarch64-linux" 
    "riscv64-linux"
    "wasm64-wasi"
    "x86_64-windows"

    # "aarch64_be-linux"
    # "alpha-linux"
    # "armv6l-linux"
    # "armv7l-linux"
    # "i386-linux"
    # "i486-linux"
    # "i586-linux"
    # "i686-linux"
    # "i686-windows"
    # "loongarch64-linux"
    # "mips-linux"
    # "mips64-linux"
    # "mips64-linuxabin32"
    # "mips64el-linux"
    # "mips64el-linuxabin32"
    # "mipsel-linux"
    # "powerpc-linux"
    # "powerpc64-linux"
    # "powerpc64le-linux"
    # "riscv32-linux"
    # "s390x-linux"
    # "sparc-linux"
    # "sparc64-linux"
    # "wasm32-wasi"
    # "x86_64-linux"
  ];


  virtualisation = {

    containers.enable = true;

    # xen.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.packages = with pkgs; [ OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;

    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   autoPrune.enable = true;
    # };
    docker = {
      enable = true;
      enableOnBoot = true;
      # storageDriver = storageDriver;
      # autoPrune.enable = true;
    };

  };

  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
    #podman-compose 
    virtualbox
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
