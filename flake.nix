{
  description = "root config file for linux";

  # example usage (run from the repo root):
  # - nix flake update
  # - nixos-rebuild switch --flake .#<output-name> --use-remote-sudo
  # - home-manager switch --flake .#<output-name> --override-input home-manager ~/<path-to-local-home-manager-repo>

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

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

    agents = {
      url = "github:numtide/llm-agents.nix";
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

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tuicr = {
      url = "github:agavra/tuicr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      disko,
      nix-gaming,
      ...
    }@inputs:

    let
      arch = "x86_64-linux";
      lib = nixpkgs.lib;
      dirs = {
        config = ./config;
      };
      pkgs = (
        import nixpkgs {
          system = arch;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
            android_sdk.accept_license = true;
            doCheckByDefault = false;
            # Explicit, per-package insecure allowances (kept visible here on
            # purpose — do not blanket-allow via NIXPKGS_ALLOW_INSECURE).
            permittedInsecurePackages = [
              "pnpm-10.29.2"
            ];
          };
          overlays = [
            (final: prev: {
              gaming = nix-gaming.packages.${arch};
            })
          ];
        }
      );

    in
    {
      formatter.${arch} = pkgs.nixfmt-tree;

      # NixOS host profiles.
      nixosConfigurations = {

        voidpc =
          let
            system = {
              inherit arch;
              host = "voidpc";
            };
            user = {
              name = "void";
            };
          in
          lib.nixosSystem {
            modules = [
              disko.nixosModules.disko
              ./nix/ingr/machines/${system.host}/hardware-configuration.nix
              ./nix/ingr/system/boot.nix
              ./nix/ingr/system/basic.nix
              ./nix/ingr/system/audio.nix
              ./nix/ingr/system/network/blocklist.nix
              ./nix/ingr/system/dev.nix
              ./nix/ingr/system/network/settings.nix
              ./nix/ingr/system/network/vpn.nix
              ./nix/ingr/system/virtualization.nix

              ./nix/ingr/system/wm/all.nix

              ./nix/ingr/system/power/pc.nix
              ./nix/ingr/system/hardware/intel.nix
              ./nix/ingr/system/hardware/storage.nix
              ./nix/ingr/system/hardware/video.nix
              ./nix/ingr/system/hardware/nvidia.nix

              ./nix/ingr/system/hardware/nfs.nix

              ./nix/ingr/system/games/gaming.nix
              ./nix/ingr/system/games/steam.nix

              # Optional service modules.
              # ./nix/ingr/system/services/homeassistant.nix
              # ./nix/ingr/system/games/game-server.nix
              ./nix/ingr/system/services/sync.nix
              ./nix/ingr/system/services/cloud.nix
              ./nix/ingr/system/services/ml.nix
              ./nix/ingr/system/services/storage.nix
              ./nix/ingr/system/services/monitoring.nix

              # Local overrides and compatibility fixes.
              ./nix/ingr/system/temp.nix

            ];

            specialArgs = { inherit system inputs user; };

          };

        vm =
          let
            system = {
              inherit arch;
              host = "voidpc";
            };
            user = {
              name = "void";
            };
          in
          lib.nixosSystem {
            modules = [
              disko.nixosModules.disko
              ./nix/ingr/machines/${system.host}/hardware-configuration.nix
              ./nix/ingr/system/boot.nix
              ./nix/ingr/system/basic.nix
              ./nix/ingr/system/network/blocklist.nix
              ./nix/ingr/system/dev.nix
              ./nix/ingr/system/network/settings.nix

              ./nix/ingr/system/wm/hyprland.nix

              ./nix/ingr/system/power/pc.nix
              ./nix/ingr/system/hardware/intel.nix
              ./nix/ingr/system/hardware/storage.nix
              ./nix/ingr/system/hardware/video.nix

              ./nix/ingr/system/hardware/nfs.nix

              # Local overrides and compatibility fixes.
              ./nix/ingr/system/temp.nix

            ];

            specialArgs = { inherit system inputs user; };

          };

        x240 =
          let
            system = {
              inherit arch;
              host = "x240";
            };
            user = {
              name = "void";
            };
          in
          lib.nixosSystem {
            modules = [
              disko.nixosModules.disko
              ./nix/ingr/machines/${system.host}/hardware-configuration.nix
              ./nix/ingr/system/boot.nix
              ./nix/ingr/system/basic.nix
              ./nix/ingr/system/network/blocklist.nix
              ./nix/ingr/system/dev.nix
              ./nix/ingr/system/network/settings.nix

              ./nix/ingr/system/wm/hyprland.nix

              ./nix/ingr/system/power/laptop.nix
              ./nix/ingr/system/hardware/intel.nix
              ./nix/ingr/system/hardware/storage.nix
              ./nix/ingr/system/hardware/video.nix

              ./nix/ingr/system/hardware/nfs.nix

              # Local overrides and compatibility fixes.
              ./nix/ingr/system/temp.nix

            ];

            specialArgs = { inherit system inputs user; };

          };
      };

      # Home Manager profiles.
      homeConfigurations = {
        void =
          let
            user = {
              name = "void";
              public_name = "utzuro";
              email = "utzuro@pm.me";
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [

              ./nix/ingr/home/home.nix
              ./nix/ingr/home/env.nix
              ./nix/ingr/home/theme.nix
              ./nix/ingr/home/fonts.nix

              ./nix/ingr/home/wm/all.nix

              ./nix/ingr/home/sh/basic.nix
              ./nix/ingr/home/sh/power.nix
              ./nix/ingr/home/sh/learn.nix
              ./nix/ingr/home/sh/dev.nix
              ./nix/ingr/home/sh/games.nix
              ./nix/ingr/home/sh/subs.nix

              ./nix/ingr/home/gui/browser.nix
              ./nix/ingr/home/gui/dev.nix
              ./nix/ingr/home/gui/media.nix
              ./nix/ingr/home/gui/comms.nix
              ./nix/ingr/home/gui/games.nix

              # ./nix/ingr/home/corp.nix

              inputs.stylix.homeModules.stylix
            ];

            extraSpecialArgs = { inherit user inputs dirs; };
          };

        # use the same user name, but different configurations for different machines
        ubuntu =
          let
            user = {
              name = "void";
              public_name = "utzuro";
              email = "utzuro@pm.me";
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./nix/ingr/home/home.nix
              ./nix/ingr/home/env.nix
              ./nix/ingr/home/fonts.nix

              ./nix/ingr/home/sh/basic.nix
              ./nix/ingr/home/sh/power.nix
              ./nix/ingr/home/sh/media.nix
              ./nix/ingr/home/sh/dev.nix
              ./nix/ingr/home/sh/games.nix

              inputs.stylix.homeModules.stylix
            ];
            extraSpecialArgs = { inherit user inputs dirs; };
          };
      };
    };
}
