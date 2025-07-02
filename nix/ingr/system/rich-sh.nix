{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # main
    neovim emacs-pgtk
    yazi vifm-full 
    ack ripgrep ripgrep-all fzf fd duf
    peco progress jq moreutils
    bat eza glow

    # archives
    unzip zip gzip xz atool zstd lz4 lzip lzo lzop rar unar p7zip 

    # tools
    killall timer xdragon
    lfs lsd lsdvd ncdu file
    rsync zsync
    usbutils 
    # monitoring
    zenith-nvidia htop iotop ddgr bottom hwinfo pciutils psmisc
    bc numbat #cava 
    ledger bc libqalculate 
    taskwarrior3 timewarrior

    # ↑ soft dependencies
    inotify-tools pistol
  ];

}
