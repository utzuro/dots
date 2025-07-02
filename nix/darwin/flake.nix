{
  description = "root config file for macOS using nix-darwin";

  # example usage:
  # - nix flake update
  # nix run nix-darwin -- switch --flake .#shigoto

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-jetbrains-plugins.url = "github:theCapypara/nix-jetbrains-plugins";
    blocklist-repo = {
      url = "github:StevenBlack/hosts";
      flake = false;
    };
  };

  outputs = { nixpkgs, nix-darwin }@inputs:

  let 
    arch = "x86_64-linux"; 
    lib = nix-darwin.lib;
    pkgs = (import nixpkgs { 
      system = arch; 
      hostPlatform = arch;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });

  in {

    # Settings are different across the machines
    nixosConfigurations = {
      
      darwinConfigurations."corp" = let
        system = {
          inherit arch; host = "corp"; 
        }; in lib.darwinSystem {
        modules = [ 
          ./dev.nix

          # Config MacOS
          ({
            nix.settings.experimental-features = "nix-command flakes";
            system.stateVersion = 5;
            nixpkgs.hostPlatform = "aarch64-darwin";

            system.defaults = {
              dock.autohide = true;
              NSGlobalDomain.AppleICUForce24HourTime = true;
              NSGlobalDomain.AppleShowAllExtensions = true;
              NSGlobalDomain.AppleInterfaceStyle = "Dark";
            };
          })

        ];
        specialArgs = { inherit system pkgs inputs; };
      };

  };
}
