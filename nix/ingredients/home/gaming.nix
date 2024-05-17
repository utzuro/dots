{ pkgs, ...}:

{
  # battlenet
  users.users.void.packages = with pkgs; [
    (wineWowPackages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    winetricks
  ];
}

