{ config, pkgs, user, inputs, ... }:

{
  imports = [

    ./home/dev-extra.nix
    ./home/media-extra.nix

  ];
}
