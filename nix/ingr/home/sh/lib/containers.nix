{ pkgs, ...}:

{

  home.packages = with pkgs [

    # only podman can go in 
    # the non-systemwide settings

  ];
}
