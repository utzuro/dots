{
  description = "nix-darwin config";

  # Example:
  # - nix flake update
  # - nix run nix-darwin -- switch --flake .#corp
  # - home-manager switch --flake .#void

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs =
    {
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      arch = "aarch64-darwin";
      lib = nix-darwin.lib;

      user = {
        name = "void";
        public_name = "utzuro";
        email = "utzuro@pm.me";
      };

      pkgs = import nixpkgs {
        system = arch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
    in
    {
      formatter.${arch} = pkgs.nixfmt-tree;

      darwinConfigurations.corp =
        let
          system = {
            inherit arch;
            host = "corp";
          };
        in
        lib.darwinSystem {
          modules = [
            ./config.nix
            ./dev.nix
          ];

          specialArgs = { inherit inputs system user; };
        };

      # Same portable shell/git/tmux setup the WSL profile gets,
      # minus Linux-only modules.
      homeConfigurations.void = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = user.name;
            home.homeDirectory = "/Users/${user.name}";
            home.stateVersion = "26.05";
            programs.home-manager.enable = true;

            # The /run-based tmux socket path does not exist on darwin.
            programs.tmux.secureSocket = nixpkgs.lib.mkForce false;
          }

          ../ingr/home/sh/core.nix
          ../ingr/home/sh/lib/git-core.nix
          ../ingr/home/sh/subs.nix
        ];

        extraSpecialArgs = { inherit user inputs; };
      };
    };
}
