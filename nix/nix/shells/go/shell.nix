{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSEnv {
  name = "go env";
  targetPkgs = pkgs: (with pkgs; [
    go
    gopls
    pkg-config
    gcc
    vips.dev
    glib.dev
  ]);
  multiPkgs = pkgs: (with pkgs; [
    vips.dev
    glib.dev
    #glibc libglibutil
  ]);
  runScript = "zsh";
}).env
