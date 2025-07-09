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
      url = { 
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/"; 
        }; 
      };
    };
  };

  home.packages = with pkgs; [ 
    onefetch 
  ];

}
