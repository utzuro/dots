{ pkgs, ... }:

{

  imports = [
    ./lib/git.nix
    ./lib/ml.nix
  ];

  home.packages = with pkgs; [
    # tools
    xc
    httpie
    grpcurl
    valgrind
    secretspec
    tig
    gitui
    #pprof
    devcontainer
    heaptrack

    # go
    go
    gopls
    gotags #gomod2nix
    gofumpt
    golangci-lint
    goda
    revive
    sqlc
    sqlfluff
    delve
    buf
    vips
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    rustup
    rustc
    cargo-edit
    cargo-watch

    # python
    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip
        setuptools
        wheel
      ]
    ))
    uv
    nox
    ruff

    # c/c++
    cmake
    llvm
    clang
    clang-tools
    ninja
    gnumake
    just
    gdb
    ccls
    ctags
    cppman

    # ruby
    ruby
    ruby-lsp
    rubyPackages.solargraph

    # functional
    nixpkgs-fmt
    nil
    ghc
    cabal-install
    stack
    ocaml
    dune_3
    elixir
    erlang

    # web
    typescript
    typescript-language-server
    eslint
    nodejs
    yarn
    pnpm
    deno

    # scripts
    shfmt
    elvish

    # other
    lua
    ghostscript

    # writing
    typst
    texlab
    texliveFull

    # devops
    tenv
    age
    kind
    kubectx
    kubectl
    graphviz
    minio-client
    awscli2
    awsebcli
    ssm-session-manager-plugin
    natscli
    lnav
    postman
    docker-slim

    # DB
    sqlite
    postgresql
    redis
    pgcli
    mariadb
    # mycli
    usql
    lazysql
    atlas

    # hardware
    avrdude
    libinput

    # system
    diffutils
    findutils
    patchelf

    # embedded
    screen
    minicom
    picocom
    tio
    bmaptool

    # docs
    doxygen
    man-pages
    man-pages-posix
    glibcInfo

  ];

  programs = {

    direnv = {
      enable = false;
      nix-direnv.enable = false;
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
        gh-dash
        gh-f
        gh-s
        gh-i
        gh-poi
        gh-eco
        gh-cal
        gh2md
      ];
    };
  };

}
