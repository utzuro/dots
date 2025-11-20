{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # Modding
    gaming.mo2installer

    # Try
    gaming.faf-client # buy on steam first
    gaming.star-citizen # try during free flight
    # gaming.northstar-proton # conflicts with flutter
    gaming.viper # ?

    # Minecraft (requies microsoft accout
    # gaming.technic-launcher
  ];
}
