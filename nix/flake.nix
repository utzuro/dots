{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
    system = {
      arch = "x86_64-linux";
    };
    user = rec {
      name = "utzuro";
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
        };
      };
    };
    homeConfigurations = {
      void = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit user;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
        };
      };
    };
  };
}
