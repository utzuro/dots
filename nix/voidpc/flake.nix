{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:utzuro/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
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
      host = "voidpc";
      musdir = "/mnt/archive/nas/mysticism/mu";
    };
    lib = nixpkgs.lib;
    pkgs = (import inputs.nixpkgs { 
      system = system.arch; 
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });
    user = {
      name = "void";
      email = "utzuro@pm.me";
      wm = "hyprland";
    };
  in {
    nixosConfigurations = {
      system = lib.nixosSystem {
        system = system.arch;
        modules = [ 
          ../ingredients/pc.nix 
          inputs.erosanix.nixosModules.protonvpn
        ];
        specialArgs = {
          inherit system;
          inherit user;
          inherit inputs;
        };
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
        extraSpecialArgs = {
          inherit user;
          inherit inputs;
        };
      };
    };
  };
}
