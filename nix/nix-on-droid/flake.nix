{
  description = "Basic example of Nix-on-Droid system config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-on-droid }:

  let
    arch = "aarch64-linux"; 
    pkgs = (import nixpkgs { 
      system = arch; 
      config = {
        # allowUnfree = true;
        # allowUnfreePredicate = (_: true);
      };
    });

  in {
    nixOnDroidConfigurations.default = 
    nix-on-droid.lib.nixOnDroidConfiguration {
      inherit pkgs;
      modules = [ 
	./system.nix
      ];
    };

    homeConfigurations = {
      v = let user = { 
	name = "void"; 
	email = "utzuro@pm.me"; 
      };
      in home-manager.lib.homeManagerConfiguration {
      modules = [ 
	./home.nix 
      ];
      extraSpecialArgs = { inherit user; };
      };
    };

  };
}
