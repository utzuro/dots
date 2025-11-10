# nix registry add microvm github:microvm-nix/microvm.nix
# nix flake init -t microvm
# nix run .#my-microvm

{
  description = "NixOS in MicroVMs";

  nixConfig = {
    extra-substituters = [ "https://microvm.cachix.org" ];
    extra-trusted-public-keys = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
  };

  inputs.microvm = {
    url = "github:microvm-nix/microvm.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, microvm }:
    let
      system = "x86_64-linux";
    in
    {
      packages.${system} = {
        default = self.packages.${system}.voidvm;
        voidvm = self.nixosConfigurations.voidvm.config.microvm.declaredRunner;
      };

      nixosConfigurations = {
        voidvm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            {
              networking.hostName = "void-network";
              users.users.root.password = "";
              microvm = {
                volumes = [{
                  mountPoint = "/var";
                  image = "var.img";
                  size = 256;
                }];
                shares = [{
                  # use proto = "virtiofs" for MicroVMs that are started by systemd
                  proto = "9p";
                  tag = "ro-store";
                  # a host's /nix/store will be picked up so that no
                  # squashfs/erofs will be built for it.
                  source = "/nix/store";
                  mountPoint = "/nix/.ro-store";
                }];

                # "qemu" has 9p built-in!
                hypervisor = "qemu";
                socket = "control.socket";
              };
            }
          ];
        };
      };
    };
}
