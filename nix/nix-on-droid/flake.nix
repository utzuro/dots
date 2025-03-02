{
  description = "Basic example of Nix-on-Droid system config.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nix-on-droid }:

  let
    arch = "aarch64-linux"; 
    pkgs = (import nixpkgs { 
      system = arch; 
      config = {
        # allowUnfree = true;
        allowUnfreePredicate = (_: true); #rar
      };
    });

  in {
    nixOnDroidConfigurations.default = 
    nix-on-droid.lib.nixOnDroidConfiguration {
      inherit pkgs;
      modules = [ 
	./system.nix
	./home.nix 
      ];
    };
  };
}
