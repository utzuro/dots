{
  description = "root config file for wsl";

  # example usage:
  # - nix flake update
  # - sudo nixos-rebuild switch --flake .#wsl --impure
  # - home-manager switch --flake .#wsl --impure

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, nixos-wsl, ... }@inputs:

    let
      arch = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = (import nixpkgs {
        system = arch;
        hostPlatform = arch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      });

    in
    {

      # Settings are different across the machines
      nixosConfigurations = {

        wsl =
          let
            system = {
              inherit arch; host = "wsl";
              storageDriver = "overlay2";
            };
          in
          lib.nixosSystem {

            modules = [
              { nix.registry.nixpkgs.flake = nixpkgs; }

              ./hardware-configuration.nix
              ./apps.nix
              ../ingr/system/sh/basic.nix
              ../ingr/system/sh/power.nix
              ../ingr/system/sh/dev.nix
              ../ingr/system/sh/games.nix

              ../ingr/system/fonts.nix

              # Setup WSL
              nixos-wsl.nixosModules.default
              {
                system.stateVersion = "24.05";
                wsl.enable = true;
                wsl.defaultUser = "void";
                wsl.docker-desktop.enable = true;
                wsl.interop.register = true;
                wsl.startMenuLaunchers = true;
                wsl.usbip.enable = true;
                wsl.useWindowsDriver = true; # OpenGL
                # wsl.wrapBinShell = true;
                wsl.wslConf = {
                  # put confs here
                  # https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconf
                  automount.enabled = true;
                  automount.ldconfig = true;
                  interop.enabled = true;
                  interop.appendWindowsPath = true;
                };
              }

            ];
            specialArgs = { inherit system pkgs inputs; };
          };
      };

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
              ../ingr/home/home.nix
              ../ingr/home/env.nix
              ../ingr/home/fonts.nix

              ../ingr/home/sh/basic.nix
              ../ingr/home/sh/power.nix
              ../ingr/home/sh/dev.nix
              ../ingr/home/sh/games.nix
              ../ingr/home/sh/subs.nix
            ];

            extraSpecialArgs = { inherit user inputs; };
          };
      };
    };
}

