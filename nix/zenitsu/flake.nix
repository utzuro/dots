{
  description = "loads config for the laptop Asus Zenbook";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; 

    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    stylix.url = "github:danth/stylix";
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = "github:emmanuelrosa/erosanix";
    erosanix.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";

    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = { nixpkgs, ...}@inputs : 
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
    };
  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = system.arch;
        modules = [ 
          ../ingredients/laptop.nix
          inputs.erosanix.nixosModules.protonvpn
          inputs.nixos-hardware.nixosModules.asus-zenbook-ux371
        ];
        specialArgs = { inherit system user inputs; };
      };
    };

    homeConfigurations = {
      void = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ../ingredients/home.nix 
          inputs.stylix.homeManagerModules.stylix 
          inputs.anyrun.homeManagerModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };
    };
  };
}
