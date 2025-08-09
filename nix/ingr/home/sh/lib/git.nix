{ config, pkgs, user, ... }:

{

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "utzuro";
    userEmail = "utzuro@pm.me";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  home.packages = with pkgs; [ 
    onefetch 
  ];

}
