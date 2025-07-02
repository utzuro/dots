{
  description = "root config file for wsl";

  # example usage:
  # - nix flake update
  # - nixos-rebuild switch --flake .#corp

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { nixpkgs, nixos-wsl, ... }@inputs: 

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

      corp = let
        system = {
          inherit arch; host = "corp"; 
        }; in lib.nixosSystem {

        modules = [
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

          # Custom modules
          ./apps.nix
        ];
        specialArgs = { inherit system pkgs inputs; };
      };
    };
  };
}

