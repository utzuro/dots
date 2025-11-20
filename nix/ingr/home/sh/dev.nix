{ pkgs, ... }:

{

  imports = [
    ./lib/git.nix
    ./lib/containers.nix
    ./lib/ml.nix
  ];

  home.packages = with pkgs; [
    # tools
    xc
    httpie
    grpcurl
    valgrind
    secretspec

    # go
    go
    gopls
    gotags #gomod2nix
    gofumpt
    golangci-lint
    revive
    sqlc
    sqlfluff
    delve
    buf
    vips
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # rust
    rustup
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

    # ruby
    # ruby
    # ruby-lsp

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

    # android
    flutter
    # androidenv.test-suite
    androidenv.androidPkgs.tools
    androidenv.androidPkgs.platform-tools
    androidenv.androidPkgs.ndk-bundle
    androidenv.androidPkgs.emulator
    androidenv.androidPkgs.androidsdk

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

    # network
    gource
    mdns
    mdns-scanner

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
    natscli
    lnav
    postman

    # ml tools
    claude-code

    # DB
    sqlite
    postgresql
    redis
    pgcli
    mariadb
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
        gh-dash
        gh-f
        gh-s
        gh-i
        gh-poi
        gh-eco
        gh-cal
        gh-copilot
        gh2md
      ];
    };
  };

}
