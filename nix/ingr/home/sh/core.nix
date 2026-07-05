# Portable CLI core shared by every host, including nix-on-droid and darwin.
# Keep desktop-only tools out of here; they belong in basic.nix.

{ pkgs, lib, ... }:

{

  imports = [
    ./lib/tmux.nix
    ./lib/zsh.nix
  ];

  home.packages =
    with pkgs;
    [

      # basic
      vim
      tmux
      rsync
      wget
      wget2 # alias target of `wget`
      curl
      file
      less

      # core
      neovim
      yazi
      ripgrep
      fzf
      fd
      jq
      bat # alias target of `cat`
      duf

    ]
    # psmisc-based killall does not build on darwin (macOS ships its own)
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ killall ];

  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "always";
    };

  };

}
