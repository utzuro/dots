{
  pkgs,
  inputs,
  user,
  ...
}:

{
  # Newest state version nix-on-droid currently accepts (enum stops at 24.05).
  system.stateVersion = "24.05";

  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs.zsh}/bin/zsh";

  environment.etcBackupExtension = ".bak";

  environment.motd = ''
    nix-on-droid / ${user.name}

    switch:
      nix-on-droid switch --flake ~/alchemy/summons/dots/nix/nix-on-droid

    storage:
      run termux-setup-storage once after Android storage permission is granted
  '';

  # Survival kit: keeps the phone usable even if the home-manager layer
  # breaks. Everyday CLI tools live in home.nix instead.
  environment.packages = with pkgs; [
    vim
    git
    tmux
    openssh
    zsh

    # unix basics
    coreutils
    findutils
    diffutils
    gnugrep
    gnused
    gnutar
    gzip
    xz
    zip
    unzip
    procps
    which
    htop

    # android
    android-tools
  ];

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
    xdg-open.enable = true;
  };

  terminal.font = "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFontMono-Regular.ttf";

  # Adapted from ../ingr/home/lib/theme.yaml (base16 "void" scheme).
  terminal.colors = {
    background = "#000000";
    foreground = "#E6E1CF";
    cursor = "#E6E1CF";

    color0 = "#000000";
    color1 = "#E02C00";
    color2 = "#E000B3";
    color3 = "#FFC74F";
    color4 = "#9A7DFF";
    color5 = "#9A50B0";
    color6 = "#7DF9FF";
    color7 = "#E6E1CF";

    color8 = "#3E3E5A";
    color9 = "#FFB86C";
    color10 = "#E000B3";
    color11 = "#FFC74F";
    color12 = "#9A7DFF";
    color13 = "#9A50B0";
    color14 = "#7DF9FF";
    color15 = "#F3F4F5";
  };

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
    accept-flake-config = true

    # Phone storage matters (values in bytes: 1G / 4G).
    auto-optimise-store = true
    min-free = ${toString (1024 * 1024 * 1024)}
    max-free = ${toString (4 * 1024 * 1024 * 1024)}

    # Avoid cooking the phone during accidental source builds.
    max-jobs = 1
    cores = 2

    # Less aggressive network parallelism than desktop.
    http-connections = 8

    log-lines = 50
  '';
}
