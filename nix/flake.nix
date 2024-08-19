{
  description = "root config file";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nur.url = github:nix-community/NUR;
    home-manager.url = github:nix-community/home-manager/master;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    stylix.url = github:danth/stylix;
    anyrun.url = github:Kirottu/anyrun;
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    erosanix.url = github:emmanuelrosa/erosanix;
    erosanix.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = github:fufexan/nix-gaming;

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    blocklist-repo = {
      url = github:StevenBlack/hosts;
      flake = false;
    };
  };

  outputs = { nixpkgs, ...}@inputs : 

  let
    system = { 
      arch = "x86_64-linux"; 
    };
    lib = nixpkgs.lib;
    pkgs = (import inputs.nixpkgs { 
      system = system.arch; 
      config = {
        allowUnfree = true;
        allowUnfreePredicate = (_: true);
      };
    });
    user = {
      name = "void";
      email = "utzuro@pm.me";
    };

  in {

    # Settings different across machines
    nixosConfigurations = {

      voidpc = let 
        host = "voidpc";
        musdir = "/mnt/archive/nas/mysticism/mu";
      in
      lib.nixosSystem {
        system = system.arch;

        modules = [ 
          ./modules/pc.nix 
          inputs.erosanix.nixosModules.protonvpn
        ];
        specialArgs = { inherit host musdir user inputs; };
      };

      zeni = lib.nixosSystem {
        system = system.arch;
        modules = [ 
          ./modules/laptop.nix
        ];
        specialArgs = { inherit system user inputs; };
      };

      x240 = lib.nixosSystem {
        system = system.arch;
        modules = [ 
          ./modules/laptop.nix
        ];
        specialArgs = { inherit system user inputs; };
      };
    };

    # Settings different across users
    homeConfigurations = {
      
      # TODO: define usere info here

      void = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./modules/home.nix 
          inputs.stylix.homeManagerModules.stylix 
          inputs.anyrun.homeManagerModules.default
        ];
        extraSpecialArgs = { inherit user inputs; };
      };

    };
  };
}
