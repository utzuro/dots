{ lib, pkgs, system, inputs, ... }:

{
  imports =
    [ 
      ./system/network.nix
    ];
