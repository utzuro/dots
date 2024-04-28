{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
  let
    system = {
      arch = "x86_64-linux";
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
    };
  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = system.arch;
        modules = [ ./configuration.nix ];
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
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit user;
          inherit inputs;
        };
      };
    };
  };
}
