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

  outputs = { nixpkgs, home-manager, ... }@inputs:

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

    in
    {

      # Settings are different across the machines
      nixosConfigurations = {

        voidpc =
          let
            system = {
              inherit arch; host = "voidpc";
              storageDriver = "overlay2";
            };
          in
          lib.nixosSystem {
            modules = [
              # Only for NixOS
              ./ingr/system/basic.nix
              ./ingr/system/dev.nix
              ./ingr/system/network/settings.nix
              ./ingr/system/network/vpn.nix
              # ./ingr/system/virtualization.nix

              ./ingr/system/wm/all.nix
              ./ingr/system/gui.nix

              ./ingr/system/power/pc.nix
              ./ingr/system/hardware/intel.nix
              ./ingr/system/hardware/video.nix
              ./ingr/system/hardware/nvidia.nix

              ./ingr/system/games/gaming.nix
              ./ingr/system/games/steam.nix

              # Below can be used on mac/wsl
              # ./ingr/system/services/homeassistant.nix
              # ./ingr/system/services/sync.nix
              # ./ingr/system/services/cloud.nix
              # ./ingr/system/services/monitoring.nix

            ];

            specialArgs = { inherit system inputs; };
          };

        x240 =
          let
            system = {
              inherit arch; host = "x240";
              storageDriver = "btrfs";
            };
          in
          lib.nixosSystem {
            modules = [
            ];
            specialArgs = { inherit system inputs; };
          };
      };


      # Settings different across users
      homeConfigurations = {
        backupFileExtension = "backup";
        void =
          let
            user = {
              name = "void";
              email = "utzuro@pm.me";
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [

              ./ingr/home/home.nix
              ./ingr/home/env.nix
              ./ingr/home/theme.nix
              ./ingr/home/fonts.nix

              ./ingr/home/wm/all.nix

              ./ingr/home/sh/basic.nix
              ./ingr/home/sh/power.nix
              ./ingr/home/sh/dev.nix
              ./ingr/home/sh/games.nix
              ./ingr/home/sh/subs.nix

              ./ingr/home/gui/browser.nix
              ./ingr/home/gui/dev.nix
              ./ingr/home/gui/media.nix
              ./ingr/home/gui/comms.nix

              inputs.stylix.homeModules.stylix
            ];

            extraSpecialArgs = { inherit user inputs; };
          };

        # use the same user name, but different configurations for different machines
        ubuntu =
          let
            user = {
              name = "void";
              email = "utzuro@pm.me";
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./ingr/home/home.nix
              ./ingr/home/env.nix
              ./ingr/home/fonts.nix

              ./ingr/home/sh/basic.nix
              ./ingr/home/sh/power.nix
              ./ingr/home/sh/dev.nix
              ./ingr/home/sh/games.nix

              inputs.stylix.homeModules.stylix
            ];
            extraSpecialArgs = { inherit user inputs; };
          };
      };
    };
}
