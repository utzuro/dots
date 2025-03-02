{ pkgs, ... }:

{
  system.stateVersion = "24.05";

  home-manager.config =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";
      # modules = [ 
        # ../ingr/home/sh.nix
      home.packages = with pkgs; [
        vim neovim emacs
        ranger yazi vifm-full 
        ack ripgrep ripgrep-all fzf fd duf
        peco progress jq moreutils
        bat eza rsync
        wget curl 

        # archives
        unzip zip gzip xz atool zstd lz4 lzip lzo lzop rar unar p7zip 

        # tools
        killall timer xdragon
        lfs lsd lsdvd ncdu file
        disfetch lolcat neofetch pfetch
        w3m asciidoctor pandoc pdftk foremost
        imagemagick ffmpeg aaxtomp3 
        htop ddgr bottom hwinfo pciutils psmisc
        bc numbat #cava 
        ledger bc libqalculate 
        inotify-tools pistol

        # media
        goread

        taskwarrior3 timewarrior
      ];
      # ];
    };
}
