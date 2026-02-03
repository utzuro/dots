{ pkgs, ... }:

{
  imports = [
    ./shared.nix
    ./autorandr.nix
  ];

  services.xserver = {
    # Keyboard layout
    xkb = {
      layout = "us";
      options = "eurosign:e,caps:escape"; # Simplified - caps as escape is useful
    };

    # Disable default xterm
    desktopManager.xterm.enable = false;

    # NVIDIA-specific X11 settings
    screenSection = ''
      Option "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option "AllowIndirectGLXProtocol" "off"
      Option "TripleBuffer" "on"
    '';
  };

  # Input - libinput for touchpad/mouse
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      naturalScrolling = true;
      tapping = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # X11 utilities
    xorg.xinput
    xorg.xrandr
    xorg.xdpyinfo
    xorg.xev # Debug keyboard/mouse events
    xorg.xprop # Window properties
    xorg.xwininfo # Window info

    # Input testing
    evtest
    antimicrox
    qjoypad
    moltengamepad

    # Clipboard
    xclip
    xsel

    # Image viewers
    dragon-drop
    sxiv
    feh

    # Compositor for X11 (reduces tearing)
    picom
  ];

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
  };

  # Picom compositor config for NVIDIA
  # Helps with screen tearing in X11
  environment.etc."xdg/picom.conf".text = ''
    # Backend - glx works best with NVIDIA
    backend = "glx";
    glx-no-stencil = true;
    glx-copy-from-front = false;

    # VSync - important for NVIDIA
    vsync = true;

    # Shadows
    shadow = false;

    # Fading
    fading = true;
    fade-delta = 4;
    fade-in-step = 0.03;
    fade-out-step = 0.03;

    # Opacity
    inactive-opacity = 1.0;
    active-opacity = 1.0;

    # Fix flickering with NVIDIA
    unredir-if-possible = false;
    
    # Performance
    use-damage = true;
  '';

}
