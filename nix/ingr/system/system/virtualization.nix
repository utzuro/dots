{ pkgs, ... }:

{

  imports = [
    ./lib/fhs.nix
  ];

  virtualisation = {

    # xen.enable = true;

    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
    users.extraGroups.vboxusers.members = [ "void" ];

    xen = {
      enable = true;
    };

    vmware = {
      host.enable = true;
    };

    libvirtd = {
      enable = true;
      programs.virt-manager.enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;

    waydroid.enable = true;

  };

  environment.systemPackages = with pkgs; [
    qemu
    virtualbox
    cabextract
  ];

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

}

