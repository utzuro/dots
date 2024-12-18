{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs;
  [
    go rustup nodejs

    (pkgs.python3.withPackages (
      python-pkgs: with python-pkgs; [
        mypy pylint
        jedi jedi-language-server
      ]))

      gopls sqlc ccls ctags gnumake
      minio-client tenv
  ];

}
