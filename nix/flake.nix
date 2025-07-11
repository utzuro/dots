{
  description = "root config file for linux";

  # example usage:
  # - nix flake update
  # - nixos-rebuild switch --flake .#<output-name> --impure --use-remote-sudo
  # - home-manager switch --flake .#<output-name> --override-input home-manager ~/<path-to-local-home-manager-repo> --impure

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    #--------------------------------------------------------

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

  outputs = {nixpkgs, home-manager, ...}@inputs : 

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

    # Settings are different across the machines
    nixosConfigurations = {

      voidpc = let 
        system = {
          inherit arch; host = "voidpc"; storageDriver = "overlay2";
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/system/boot.nix
          ./ingr/linux.nix 
          ./ingr/pkgs.nix
          # ./ingr/extra.nix 
          ./ingr/wm.nix
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
          inherit arch; host = "msi"; storageDriver = "overlay2";
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/system/boot.nix
          # ./ingr/system/corporate.nix
          ./ingr/linux.nix 
          # ./ingr/pkgs.nix
          # ./ingr/extra.nix 
          ./ingr/wm.nix
          ./ingr/workstation.nix
        ];
        specialArgs = { inherit system inputs; }; 
      };

      zeni = let 
        system = {
          inherit arch; host = "zeni"; storageDriver = "btrfs";
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/general.nix
          ./ingr/laptop.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };

      x240 = let 
        system = {
          inherit arch; host = "x240"; storageDriver = "btrfs";
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/general.nix
          ./ingr/low-laptop.nix 
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
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./ingr/home.nix 
          inputs.stylix.homeModules.stylix 
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
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

    };
  };
}
