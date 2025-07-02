{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
      };
    };
  };
}

