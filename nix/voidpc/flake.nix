{
  description = "root config file";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://anyrun.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = "github:danth/stylix";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    # erosanix.url = "github:emmanuelrosa/erosanix";
    # erosanix.inputs.nixpkgs.follows = "nixpkgs";

    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, anyrun, ... }: 
  let
    system = { arch = "x86_64-linux"; host = "voidpc";
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
        modules = [ 
          ../ingredients/home.nix 
          stylix.homeManagerModules.stylix 
          # erosanix.nixosModules.protonvpn
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
