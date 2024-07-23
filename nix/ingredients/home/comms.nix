{ pkgs, ... }:

{
  programs.bitlbee = {
    enable = true;
    plugins = with pkgs; [
      bitlbee-discord
      bitlbee-facebook
      bitlbee-steam
    ];

  };
  home.packages = with pkgs; [
    # chats
    # threema-desktop
    signal-desktop 
    signald signaldctl signal-cli
    webcord discord telegram-desktop
    protonmail-desktop
  ];
}
