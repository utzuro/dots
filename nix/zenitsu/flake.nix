{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:danth/stylix";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = "github:emmanuelrosa/erosanix";
    erosanix.inputs.nixpkgs.follows = "nixpkgs";

    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, anyrun, erosanix, ... }: 
  let
    system = { 
      arch = "x86_64-linux"; 
      host = "zenitsu";
      musdir = "/home/void/magic/mysticism/mu";
    };
    lib = nixpkgs.lib;
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
        modules = [ 
          ../ingredients/laptop.nix
          # erosanix.nixosModules.protonvpn
        ];
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
        modules = [ 
          ../ingredients/home.nix 
          stylix.homeManagerModules.stylix 
          anyrun.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit user;
          inherit inputs;
        };
      };
    };
  };
}
