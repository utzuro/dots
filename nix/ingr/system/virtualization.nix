{ pkgs, ... }:

{

  imports = [
    ./lib/fhs.nix
  ];

  users.extraGroups.vboxusers.members = [ "void" ];
  virtualisation = {

    libvirtd = {
      enable = true;
      virt-manager.enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;

    waydroid.enable = true;

    # Works but libvirtd is better on linux
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    #   enableKvm = true; #experimental
    # };
    # vmware = {
    #   host.enable = true;
    # };

    # Potentially cases host to become slower
    # xen = {
    #   enable = true;
    #   efi.bootBuilderVerbosity = "info";
    #   bootParams = [
    #     "vga=ask" # for highres
    #     "dom0=pvh" # PVH virt mode for Domain 0, instead of PV.
    #   ];
    #   dom0Resources = {
    #     # memory = 1024; # Only allocates 1GiB of memory to the Domain 0, with the rest of the system memory being freely available to other domains.
    #     # maxVCPUs = 2; # Allows the Domain 0 to use, at most, two CPU cores.
    #   };
    # };

  };

  # GUI
  programs.virt-manager.enable = true;

  # Enable UEFI
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

  environment.systemPackages = with pkgs; [
    qemu
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

