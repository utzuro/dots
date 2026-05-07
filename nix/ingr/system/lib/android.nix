{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    androidenv.test-suite
    androidenv.androidPkgs.all
  ];
}

