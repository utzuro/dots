{ config, pkgs, user, ... }:

{

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = user.name;
    userEmail = user.email;
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
