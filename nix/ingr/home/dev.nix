{ pkgs, ...}:

{
  home.packages = with pkgs; [

    # dev

    ## go
    go gopls gotags 
    gofumpt golangci-lint
    sqlc delve buf

    ## rust
    rustup
    cargo-edit cargo-watch

    ## python
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip setuptools wheel
      ]))
    uv nox

    ## c/c++
    cmake clang clang-tools llvm 
    ninja gnumake gdb
    ccls ctags

    ## lower
    patchelf

    ## functional
    nixpkgs-fmt nil
    ghc cabal-install stack
    ocaml dune_3

    ## other
    php nodejs lua dart

    # devops
    tenv age

    # tools
    graphviz
    minio-client awscli2 awsebcli
    natscli
    # gh gh-dash gh-f gh-s gh-i gh-poi gh-eco gh-cal gh-copilot gh2md
    
    # AI
    ollama
    claude-code
    openvino

    # DB
    sqlite postgresql redis
    pgcli 

    # hardware
    avrdude
  ];

  programs.gh = {
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
  };

}
