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
          android_sdk.accept_license = true;
        };
      });

    in
    {

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
              ../ingr/system/basic.nix
              ./ingr/system/dev.nix
              ./ingr/system/network/settings.nix

              ../ingr/system/fonts.nix

              # Setup WSL
              nixos-wsl.nixosModules.default
              {
                wsl = {
                  enable = true;
                  defaultUser = "void";
                  docker-desktop.enable = false;
                  useWindowsDriver = false; # OpenGL
                  startMenuLaunchers = false;
                  interop = {
                    includePath = false;
                    register = false;
                  };
                  usbip.enable = false;
                  wsl.wrapBinSh = true;
                  wslConf = {
                    # https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconf
                    automount = {
                      enabled = false;
                      ldconfig = false;
                    };
                    interop = {
                      enabled = false;
                      appendWindowsPath = false;
                    };
                    network = {
                      generateHosts = true;
                      generateResolvConf = true;
                      hostname = "vois-wsl";
                    };
                  };

                  systemd.services.wsl-keepalive = {
                    description = "Keep WSL VM alive";
                    wantedBy = [ "multi-user.target" ];
                    after = [ "network.target" ];

                    serviceConfig = {
                      Type = "simple";
                      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep infinity'";
                    };
                  };

                  system.stateVersion = "24.05";
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

