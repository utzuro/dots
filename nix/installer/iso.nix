# Build:
#   export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-unstable
#   nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -o result-iso
#
# ISO will be under:
#   result-iso/iso/*.iso

{
  lib,
  pkgs,
  modulesPath,
  ...
}:

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

  summons = lib.cleanSourceWith {
    src = ./summons;
  };

  # Game data lives outside the repo (~/.local/share/vcmi); only embed it
  # when building on a machine that actually has it.
  vcmiPath = ../../../.local/share/vcmi;
  hasVcmi = builtins.pathExists vcmiPath;
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

  boot.supportedFilesystems = {
    btrfs = true;
    cifs = true;
    exfat = true;
    ext4 = true;
    f2fs = true;
    ntfs = true;
    reiserfs = true;
    vfat = true;
    xfs = true;
    # the base installer module enables zfs, which lags behind
    # linuxPackages_latest and breaks evaluation
    zfs = lib.mkForce false;
  };

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
  # mkForce: ../ingr/system/lib/system.nix sets 50 for installed systems;
  # live media has no disk swap to fall back on.
  zramSwap.memoryPercent = lib.mkForce 100;
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "80%";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      liveUser
      normalUser
    ];
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
    # shell comes from ../ingr/system/lib/user.nix (via basic.nix -> core.nix)
    extraGroups = commonGroups;

    initialPassword = normalUser;
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
    # mkForce: ../ingr/system/lib/containers.nix enables it on boot for
    # installed systems, but live media should stay lazy.
    enableOnBoot = lib.mkForce false;

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
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
  ];

  # Put your zsh/vim/nvim config into the live users' homes.
  # Symlinks point into the immutable Nix store, which is good for a live ISO.
  system.activationScripts.liveDotfiles = {
    deps = [ "users" ];
    text = ''
      for u in ${
        lib.escapeShellArgs [
          liveUser
          normalUser
        ]
      }; do
        if ! id "$u" >/dev/null 2>&1; then
          continue
        fi

        home="$(getent passwd "$u" | cut -d: -f6)"
        if [ -z "$home" ]; then
          continue
        fi

        install -d -m 0755 -o "$u" -g users "$home"
        install -d -m 0755 -o "$u" -g users "$home/.config"

        if [ -e ${dotfiles}/zsh/.zshrc ]; then
          ln -sfn ${dotfiles}/zsh/.zshrc "$home/.zshrc"
          chown -h "$u:users" "$home/.zshrc" || true
        fi

        if [ -e ${dotfiles}/zsh/.p10k.zsh ]; then
          ln -sfn ${dotfiles}/zsh/.p10k.zsh "$home/.p10k.zsh"
          chown -h "$u:users" "$home/.p10k.zsh" || true
        fi

        if [ -e ${dotfiles}/vim/vimrc ]; then
          ln -sfn ${dotfiles}/vim/vimrc "$home/.vimrc"
          chown -h "$u:users" "$home/.vimrc" || true
        fi

        if [ -e ${dotfiles}/vim/nvim ]; then
          rm -rf "$home/.config/nvim"
          ln -sfn ${dotfiles}/vim/nvim "$home/.config/nvim"
          chown -h "$u:users" "$home/.config/nvim" || true
        fi
      done
    '';
  };

  # embed a copy of the config repo into /etc/nixos/voidos.
  # ../.. is the repo root: the main flake.nix lives there, so the embedded
  # copy is directly usable with `nixos-rebuild switch --flake`.
  environment.etc."nixos/voidos".source = lib.cleanSourceWith {
    src = ../..;
    filter =
      path: type:
      let
        name = baseNameOf path;
      in
      !(
        # sockets and other special files (e.g. microvm control.socket)
        type == "unknown"
        || name == ".git"
        || name == ".claude"
        || name == "result"
        || name == "result-iso"
        || name == "secrets"
        || name == "hashedPasswordFile"
      );
  };

  isoImage.contents = [
    {
      source = summons;
      target = "/summons";
    }
  ]
  ++ lib.optional hasVcmi {
    source = lib.cleanSourceWith { src = vcmiPath; };
    target = "/home/${normalUser}/.local/share/vcmi";
  };

  # Avoid audit/journald option conflicts in the graphical installer image.
  services.journald.audit = false;
  security.audit.enable = lib.mkForce false;
  security.auditd.enable = false;
  programs.command-not-found.enable = lib.mkForce true;
}
