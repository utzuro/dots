{
  description = "root config file";

  # example usage:
  # - nix flake update
  # - nixos-rebuild switch --flake .#<output-name> --impure --use-remote-sudo
  # - home-manager switch --flake .#<output-name> --override-input home-manager ~/<path-to-local-home-manager-repo> --impure
  # nix run nix-darwin -- switch --flake .#shigoto

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    stylix = {
      url = "github:danth/stylix"; 
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
    # anyrun = { 
    #   url = "github:Kirottu/anyrun";
    #   inputs.nixpkgs.follows = "nixpkgs"; 
    # };
    
    erosanix = {
      url = "github:emmanuelrosa/erosanix";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    nix-jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    
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

  outputs = {nix-darwin, nixpkgs, home-manager, ...}@inputs : 

  let
    arch = "x86_64-linux"; 
    lib = nixpkgs.lib;
    pkgs = (import nixpkgs { 
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
          ./ingr/system/boot.nix
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

      msi = let 
        system = {
          inherit arch; host = "msi"; 
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/system/boot.nix
          ./ingr/general.nix 
          ./ingr/workstation.nix
          ./ingr/corporate.nix
        ];
        specialArgs = { inherit system inputs; }; 
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
          ./ingr/low-laptop.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };
    };


    darwinConfigurations."shigoto" = nix-darwin.lib.darwinSystem {
      modules = [ 
        inputs.configuration 
      ];
    };

    # Settings different across users
    homeConfigurations = { 
      backupFileExtension = "backup";
      void = let user = { 
        name = "void"; 
        email = "utzuro@pm.me"; 
      };
        in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          # in home, check if hyprland and other options are enabled 
          # before configuring them
          ./ingr/home.nix 
          # Try to import it from the inside
          inputs.stylix.homeModules.stylix 
          # inputs.anyrun.homeModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

      v = let user = { 
        name = "void"; 
        email = "utzuro@pm.me"; 
      };
        in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./ingr/home-minimal.nix 
          inputs.stylix.homeModules.stylix 
          # inputs.anyrun.homeModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

    };
  };
}
