{
  description = "WIP";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux"; 
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      void = lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [ ../configuration.nix ];
      };
    };

    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
