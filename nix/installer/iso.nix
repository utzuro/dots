# Build:
#   export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-unstable
#   nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -o result-iso
#
# ISO will be under:
#   result-iso/iso/*.iso

{ lib, pkgs, modulesPath, ... }:

let
  liveUser = "nixos";
  normalUser = "void";

  user = {
    name = normalUser;
  };

  dotfiles = ../../config;

  commonGroups = [
    "wheel"
    "networkmanager"
    "docker"
    "libvirtd"
    "kvm"
    "input"
    "render"
    "video"
    "audio"
    "gamemode"
  ];
in
{
  _module.args = {
    inherit user;

    isIso = true;

    system = {
      arch = "x86_64-linux";
      host = "voidos-live";
      isLiveIso = true;
    };
  };

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"

    ../ingr/system/basic.nix
    ../ingr/system/dev.nix
    ../ingr/system/network/settings.nix
    ../ingr/system/virtualization.nix
    ../ingr/system/wm/all.nix
    ../ingr/system/games/gaming.nix
    ../ingr/system/games/steam.nix
    ../ingr/system/temp.nix
    ../ingr/system/hardware/storage.nix
    ../ingr/system/hardware/nfs.nix

    # ../ingr/system/hardware/nvidia.nix
  ];

  networking.hostName = "voidos-live";

  nixpkgs.config.allowUnfree = true;

  isoImage.edition = "voidos-live";

  isoImage.squashfsCompression = "zstd -Xcompression-level 19";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems = [
    "btrfs"
    "cifs"
    "exfat"
    "ext4"
    "f2fs"
    "ntfs"
    "reiserfs"
    "vfat"
    "xfs"
  ];

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.fwupd.enable = true;

  networking.networkmanager.enable = true;

  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "80%";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" liveUser normalUser ];
    max-jobs = "auto";
    cores = 0;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.${liveUser} = {
    shell = pkgs.zsh;
    extraGroups = commonGroups;
  };

  users.users.${normalUser} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = commonGroups;

    initialHashedPassword = ""; # TODO
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = liveUser;
  };

  services.getty.autologinUser = liveUser;

  # Containers.
  virtualisation.docker = {
    enable = true;

    # Avoid starting Docker at boot; socket activation can start it on demand.
    enableOnBoot = false;

    # Default overlay2 is usually best. For weird live-media failures, try:
    # daemon.settings."storage-driver" = "vfs";
  };

  # VMs.
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";

    qemu = {
      # pkgs.qemu is larger, but more flexible than qemu_kvm on random machines.
      package = pkgs.qemu;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  programs.virt-manager.enable = true;

  # Gaming.
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  # Your toolbox.
  environment.systemPackages = with pkgs; [
    # Installer/recovery/mounting
    gparted
    parted
    gptfdisk
    dosfstools
    exfatprogs
    ntfs3g
    btrfs-progs
    xfsprogs
    e2fsprogs
    cryptsetup
    lvm2
    mdadm
    smartmontools
    nvme-cli
    cifs-utils
    nfs-utils
    sshfs

    # Hardware inspection
    pciutils
    usbutils
    lshw
    dmidecode

    # Shell/dev basics
    git
    git-lfs
    gh
    curl
    wget
    rsync
    jq
    yq
    ripgrep
    fd
    fzf
    bat
    eza
    tree
    tmux
    htop
    btop
    file
    which
    unzip
    p7zip

    # Editors
    vim
    neovim

    # Build tools
    gcc
    clang
    gnumake
    cmake
    ninja
    pkg-config
    gdb
    strace
    ltrace
    lsof

    # Language/runtime tools
    python3
    nodejs
    go
    rustup

    # Nix/dev UX
    direnv
    nix-direnv
    nix-output-monitor
    nh

    # Containers/VMs
    docker-compose
    qemu
    virt-manager
    virtiofsd

    # GUI apps
    firefox
    alacritty

    # Gaming/debug
    mangohud
    gamescope
    vulkan-tools
    mesa-demos

    # Actual games included in the ISO store.
    # Remove these if ISO size gets silly.
    xonotic
    superTuxKart

    # Useful for running random FHS-ish Linux binaries.
    steam-run
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    dejavu_fonts
  ];

  # Put your zsh/vim/nvim config into the live users' homes.
  # Symlinks point into the immutable Nix store, which is good for a live ISO.
  system.activationScripts.liveDotfiles = {
    deps = [ "users" ];
    text = ''
      for u in ${lib.escapeShellArgs [ liveUser normalUser ]}; do
        if ! id "$u" >/dev/null 2>&1; then
          continue
        fi

        home="$(getent passwd "$u" | cut -d: -f6)"
        if [ -z "$home" ]; then
          continue
        fi

        install -d -m 0755 -o "$u" -g users "$home"
        install -d -m 0755 -o "$u" -g users "$home/.config"

        if [ -e ${dotfiles}/zshrc ]; then
          ln -sfn ${dotfiles}/zshrc "$home/.zshrc"
          chown -h "$u:users" "$home/.zshrc" || true
        fi

        if [ -e ${dotfiles}/vimrc ]; then
          ln -sfn ${dotfiles}/vimrc "$home/.vimrc"
          chown -h "$u:users" "$home/.vimrc" || true
        fi

        if [ -e ${dotfiles}/nvim ]; then
          rm -rf "$home/.config/nvim"
          ln -sfn ${dotfiles}/nvim "$home/.config/nvim"
          chown -h "$u:users" "$home/.config/nvim" || true
        fi
      done
    '';
  };

  # embed a copy of config repo into /etc/nixos/voidos.
  environment.etc."nixos/voidos".source = lib.cleanSourceWith {
    src = ../.;
    filter = path: type:
      let name = baseNameOf path;
      in !(name == ".git"
        || name == "result"
        || name == "result-iso"
        || name == "secrets"
        || name == "hashedPasswordFile");
  };

  # conflict fixes
  services.journald.audit = false;
  security.audit.enable = lib.mkForce false;
  security.auditd.enable = false;
  programs.command-not-found.enable = lib.mkForce true;
}
