{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs;
      [
        # cli
        neovim yazi 
        ack ripgrep ripgrep-all fzf fd duf
        peco progress jq
        bat eza rsync
        wget curl 

        # archives
        unzip zip gzip xz unar

        # tools
        asciidoctor pandoc pdftk 
        imagemagick ffmpeg
        ledger taskwarrior3
      ];

      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";

      fonts.packages = with pkgs; [
        monaspace nerd-fonts._0xproto font-awesome
      ];

      system.defaults = {
        dock.autohide = true;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleShowAllExtensions = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
      };
    };
  in
  {
    # $ nix flake update
    # $ nix run nix-darwin -- switch --flake .#shigoto
    darwinConfigurations."shigoto" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration 
        ./dev.nix
      ];
    };
  };
}
