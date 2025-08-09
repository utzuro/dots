{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ( import ./lib/containers.nix {
        inherit pkgs lib system;
      })
      ./lib/ml.nix
    ];

    programs.adb.enable = true;
    services.flatpak.enable = true;

    xdg.portal.wlr.enable = true;
    environment.systemPackages = with pkgs; [
      appimage-run
    ];

    environment.systemPackages = with pkgs; [

      # tools
      xc nodejs httpie

      # go
      go gopls gotags #gomod2nix
      gofumpt golangci-lint revive
      sqlc delve buf
      vips protobuf
      protoc-gen-go protoc-gen-go-grpc

      # rust
      rustup
      cargo-edit cargo-watch

      # python
      (pkgs.python3.withPackages (
        python-pkgs: with python-pkgs; [
          pip setuptools wheel
        ]))
      uv nox

      # c/c++
      cmake llvm clang clang-tools
      ninja gnumake gdb
      ccls ctags

      # ruby
      ruby ruby-lsp

      # functional
      nixpkgs-fmt nil
      ghc cabal-install stack
      ocaml dune_3
      elixir erlang

      # web
      typescript typescript-language-server eslint
      nodejs yarn pnpm deno

      # android
      flutter

      # other
      lua ghostscript

      # network
      gource

      # devops
      tenv age 
      kind kubectx kubectl
      graphviz
      minio-client awscli2 awsebcli
      natscli
      lnav
      postman
      
      # ml tools
      claude-code 

      # DB
      sqlite postgresql redis pgcli 

      # hardware
      avrdude

      # system
      diffutils findutils
      patchelf

      # embedded
      screen minicom picocom tio bmaptool

    ];

}

