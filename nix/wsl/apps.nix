{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      # WSL specific packages here

    ];

  # Required to work for apps like vscode
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    ## If needed, you can add missing libraries here. nix-index-database is your friend to
    ## find the name of the package from the error message:
    ## https://github.com/nix-community/nix-index-database
    # libraries = options.programs.ni
  };
}
