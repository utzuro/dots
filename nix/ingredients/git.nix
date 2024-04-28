{ config, pkgs, user, ... }:

{
  home.packages = with pkgs; [ 
    git git-lfs
    onefetch 
  ];
  programs.git = {
    enable = true;
    userName = user.name;
    userEmail = user.email;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

}
