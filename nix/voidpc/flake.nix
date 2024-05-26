{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, ... }: 
  let
    system = {
      arch = "x86_64-linux";
      host = "voidpc";
    };
    lib = nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${system.arch};
    pkgs = (import inputs.nixpkgs { 
      system = system.arch; 
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });
    user = rec {
      name = "void";
      email = "utzuro@pm.me";
      wm = "i3";
    };
  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = system.arch;
        modules = [ ../ingredients/pc.nix ];
        specialArgs = {
          inherit system;
          inherit user;
          inherit inputs;
        };
      };
    };

    homeConfigurations = {
      void = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ stylix.homeManagerModules.stylix ../ingredients/home.nix ];
        extraSpecialArgs = {
          inherit user;
          inherit inputs;
        };
      };
    };
  };
}
