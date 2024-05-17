{ pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    kdePackages.qt6ct
    gnome3.adwaita-icon-theme # required for lutris
  ];

}
