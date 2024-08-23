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
  };
  services.libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };

  environment.systemPackages = with pkgs; [
    xclip
    sxiv feh
  ];

  services = {
    gnome = {
      gnome-keyring.enable = true;
    };
    dbus = {
      enable = true;
    };
  };

  programs = {
    light.enable = true;
  };
    
}


