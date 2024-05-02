{ pkgs, ...}:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      options = "eurosign:e,setxkbmap -option grp:switch,grp:caps_toggle,grp_led:caps us,ua";
    };
    desktopManager = {
      xterm.enable = false;
    };
    # displayManager = {
    #   lightdm.enable = true;
    #   sessionCommands = ''
    #     # put confgs here
    #   '';
    # };
    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
  };

  services = {
    gnome = {
      gnome-keyring.enable = true;
    };
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };
    
}


