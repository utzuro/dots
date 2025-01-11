{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nur.url = github:nix-community/NUR;
    
    stylix = {
      url = github:danth/stylix; 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprlux = {
      url = "github:amadejkastelic/Hyprlux";
    };
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow/tags/v0.36.0";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-easymotion = {
      url = "github:zakk4223/hyprland-easymotion";
      inputs.hyprland.follows = "hyprland";
    };

    
    # tools
    anyrun = { 
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
    
    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
    
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = {...}@inputs : 

  let
    arch = "x86_64-linux"; 
    lib = inputs.nixpkgs.lib;
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
          ./ingr/general.nix 
          ./ingr/pc.nix 
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
          ./ingr/general.nix
          ./ingr/laptop.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };

      x240 = let 
        system = {
          inherit arch; host = "x240"; 
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/general.nix
          ./ingr/laptop.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };
    };

    # Settings different across users
    homeConfigurations = { 
      backupFileExtension = "backup";
      void = let user = { 
        name = "void"; 
        email = "utzuro@pm.me"; 
      };
        in inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          # in home, check if hyprland and other options are enabled 
          # before configuring them
          ./ingr/home.nix 
          # Try to import it from the inside
          inputs.stylix.homeManagerModules.stylix 
          inputs.anyrun.homeManagerModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

    };
  };
}
