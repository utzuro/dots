{ pkgs, ...}:

{

  home.packages = with pkgs; [

    # tools
    xc

    # go
    go gopls gotags #gomod2nix
    gofumpt golangci-lint
    sqlc delve buf

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
    cmake clang clang-tools llvm 
    ninja gnumake gdb
    ccls ctags

    # functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    # web
    nodejs yarn php
    typescript typescript-language-server eslint

    # other
    lua dart

    # network
    gource

    # devops
    tenv age 
    kind kubectx kubectl
    graphviz
    minio-client awscli2 awsebcli
    natscli
    lnav
    
    # AI
    ollama claude-code openvino

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

  programs = {
    
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
      extensions = with pkgs; [
        gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot gh2md
      ];
    }; # gh
  }; # programs

}
