# Usually GUI apps are installed with the Home-Manager
# But those are unavailable there.
{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [
      (import ./lib/jetbrains.nix {
        inherit pkgs lib system;
        plugins = inputs.nix-jetbrains-plugins;
      })
    ];

}

