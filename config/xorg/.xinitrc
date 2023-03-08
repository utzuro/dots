#!/bin/sh

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

# Touch
MOZ_USE_XINPUT2=1

i3
