{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Modding
    gaming.mo2installer

    # Try
    gaming.faf-client
    gaming.star-citizen # try during free flight

    # Minecraft (requies microsoft accout
    # gaming.technic-launcher
  ];
}
