{
  description = "nix-darwin config";

  # Example:
  # - nix flake update
  # - nix run nix-darwin -- switch --flake .#corp

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

  outputs = { nix-darwin, ... }@inputs:
    let
      arch = "aarch64-darwin";
      lib = nix-darwin.lib;
    in
    {
      darwinConfigurations.corp =
        let
          system = {
            inherit arch;
            host = "corp";
          };
        in
        lib.darwinSystem {
          modules = [
            ./dev.nix
            {
              nix.settings.experimental-features = "nix-command flakes";
              nixpkgs.hostPlatform = arch;
              system.stateVersion = 5;

              system.defaults = {
                dock.autohide = true;
                NSGlobalDomain.AppleICUForce24HourTime = true;
                NSGlobalDomain.AppleShowAllExtensions = true;
                NSGlobalDomain.AppleInterfaceStyle = "Dark";
              };
            }
          ];

          specialArgs = { inherit inputs system; };
        };
    };
}
