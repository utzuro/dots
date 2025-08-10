{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      go
      rustup
      nodejs

      pyright
      (pkgs.python3.withPackages (
        python-pkgs: with python-pkgs; [ ] # no need for global pkgs yet
      ))

      gopls
      sqlc
      ccls
      ctags
      gnumake
      minio-client
      tenv

      nil
    ];
}
