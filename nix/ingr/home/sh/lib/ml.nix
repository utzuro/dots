{ pkgs, ... }:

{

  home.packages = with pkgs; [
    tesseract
    ocrmypdf

    # agents
    codex
    claude-code
    opencode

  ];

}
