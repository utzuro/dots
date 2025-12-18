{ pkgs, ... }:

{

  home.packages = with pkgs; [
    tesseract
    ocrmypdf

    # agents
    codex
    claude-code
    copilot-cli

  ];

}
