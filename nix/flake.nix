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
          ./ingr/system/system/linux.nix
          ./ingr/system/system/wm/all.nix
          ./ingr/system/system/virtualization.nix

          ./ingr/system/system/power/pc.nix
          ./ingr/system/system/hardware/intel.nix
          ./ingr/system/system/hardware/video.nix
          ./ingr/system/system/hardware/nvidia.nix
          
          ./ingr/system/sh/basic.nix
          ./ingr/system/sh/rich.nix
          ./ingr/system/sh/games.nix


          # ./ingr/system/boot.nix
          # ./ingr/linux.nix 
          # ./ingr/pkgs.nix
          # ./ingr/pkgs-dev.nix
          # ./ingr/pkgs-network.nix
          # ./ingr/pkgs-extra.nix 
          # ./ingr/dev-extra.nix 
          # ./ingr/wm.nix
          # ./ingr/pc.nix 
        ];
        specialArgs = { inherit system inputs; }; 
      };

      x240 = let 
        system = {
          inherit arch; host = "x240"; storageDriver = "btrfs";
        }; in lib.nixosSystem {
        modules = [ 
          ./ingr/system/boot.nix
          ./ingr/system/corporate.nix
          ./ingr/linux.nix 
          ./ingr/pkgs.nix
          ./ingr/extra.nix 
          ./ingr/wm.nix
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
          ./ingr/home/home.nix 
          ./ingr/home/home-dev.nix 
          ./ingr/home/home-extra.nix 
          ./ingr/home/home-gui.nix 
          ./ingr/home/home-theme.nix 
          ./ingr/home/home/wm.nix
          ./ingr/home/home-gaming.nix 
          inputs.stylix.homeModules.stylix 
        ];
        extraSpecialArgs = { inherit user inputs; };
      };
      # use the same user name, but different configurations for different machines
      ubuntu = let user = { 
        name = "void"; 
        email = "utzuro@pm.me"; 
      };
      in home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./ingr/home.nix 
          ./ingr/home-dev.nix 
          #./ingr/home-theme.nix 
          inputs.stylix.homeModules.stylix 
        ];
        extraSpecialArgs = { inherit user inputs; };
      };
    };
  };
}
