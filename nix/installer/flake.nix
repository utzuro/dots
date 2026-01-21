{
  description = "initial flake for the fresh installation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs
    , disko
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.zammadn = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
        ];
      };
      formatter.${system} = pkgs.nixfmt-tree;
    };
}

