{ pkgs, ...}:

{

  environment.systemPackages = with pkgs; [
    kdePackages.qt6ct
  ];

}
