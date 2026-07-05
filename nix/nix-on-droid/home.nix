{ user, inputs, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";

    extraSpecialArgs = { inherit user inputs; };

    config =
      { pkgs, ... }:
      {
        # nix-on-droid wires home.username and home.homeDirectory itself;
        # do not import ../ingr/home/home.nix (it assumes /home/<user>).
        home.stateVersion = "26.05";

        imports = [
          ../ingr/home/sh/core.nix
          ../ingr/home/sh/lib/git-core.nix
          ../ingr/home/sh/subs.nix
        ];

        home.sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          PAGER = "less -R";
        };

        home.sessionPath = [
          "$HOME/.local/bin"
        ];

        # phone-specific aliases on top of the shared aliases.nix set
        programs.zsh.shellAliases = {
          open = "termux-open";
          storage = "cd ~/storage/shared";
          rebuild-phone = "nix-on-droid switch --flake ~/alchemy/summons/dots/nix/nix-on-droid";
        };

        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
          settings."*" = {
            compression = true;
            serverAliveInterval = 60;
            serverAliveCountMax = 3;
          };
        };
      };
  };
}
