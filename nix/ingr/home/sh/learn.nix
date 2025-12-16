{ pkgs, ... }:

{

  home.packages = with pkgs; [
    ki
    markdown-anki-decks
  ];

}
