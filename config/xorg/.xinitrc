#!/bin/sh
# Load configs
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# Run system scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

twm &

# Keyboard layout
setxkbmap -option grp:switch,grp:caps_toggle,grp_led:caps us,ua

# Desktop variables
export TDESKTOP_USE_GTK_FILE_DIALOG=1
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_AUTO_SCREEN_SCALE_FACTOR=1
# 4K setup
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=1
# MIDI (for DosBox)
export SDL_SOUNDFONTS=/usr/share/soundfonts/default.sf2
# Japanese input
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
export XMODIFIERS='@im=uim'
