{
  description = "nix-on-droid phone config";

  # usage (on the phone, from this directory):
  # - nix flake update
  # - nix-on-droid switch --flake .

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-on-droid,
      ...
    }@inputs:

    let
      arch = "aarch64-linux";

      user = {
        name = "void";
        public_name = "utzuro";
        email = "utzuro@pm.me";
      };

      pkgs = (
        import nixpkgs {
          system = arch;
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true); # rar
          };
          overlays = [
            nix-on-droid.overlays.default
          ];
        }
      );

    in
    {
      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        inherit pkgs;
        modules = [
          ./system.nix
          ./home.nix
        ];

        # flake-native home-manager instead of the old channel bootstrap
        home-manager-path = home-manager.outPath;

        extraSpecialArgs = { inherit inputs user; };
      };
    };
}
