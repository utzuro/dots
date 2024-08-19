{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nur.url = github:nix-community/NUR;
    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = github:danth/stylix;
    anyrun.url = github:Kirottu/anyrun;
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = github:emmanuelrosa/erosanix;
    erosanix.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = github:fufexan/nix-gaming;

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    blocklist-repo = {
      url = github:StevenBlack/hosts;
      flake = false;
    };
  };

  outputs = { nixpkgs, ...}@inputs : 

  let
    arch = "x86_64-linux"; 
    lib = nixpkgs.lib;
    pkgs = (import inputs.nixpkgs { 
      system = arch; 
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });

  in {

    # Settings different across machines
    nixosConfigurations = {

      voidpc = let 
        system = {
          inherit arch; host = "voidpc"; 
        }; in lib.nixosSystem {
        modules = [ 
          ./modules/general.nix 
          ./modules/pc.nix 
        ];
        specialArgs = { inherit system inputs; }; 

        # TODO: create options
        # video.nvidia.enable = true;
        # gaming.extra = true; # TODO: move gaming from the HM

        # wm.hyprland.enable = true;
        # wm.kde.enable = true;
        # wm.i3.enable = true;
      };

      zeni = let 
        system = {
          inherit arch; host = "zeni"; 
        }; in lib.nixosSystem {
        modules = [ 
          ./modules/general.nix
          ./modules/laptop.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };

    };

    # Settings different across users
    homeConfigurations = { 
      void = let user = { 
        name = "void"; 
        email = "utzuro@pm.me"; 
      };
        in inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          # in home, check if hyprland and other options are enabled before configuring them
          ./modules/home.nix 
          # Try to import it from the inside
          inputs.stylix.homeManagerModules.stylix 
          inputs.anyrun.homeManagerModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

    };
  };
}
