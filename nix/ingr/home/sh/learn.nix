{ pkgs, ... }:

{

  home.packages = with pkgs; [
    markdown-anki-decks
  ];

}
