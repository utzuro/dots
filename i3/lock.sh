#!/usr/bin/env bash

pkill -u "$USER" -USR1 dunst

# icon="$HOME/.config/i3/lock.png"
# tmpbg='/tmp/screen.png'

# scrot "$tmpbg"

# convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# convert "$tmpbg" "$icon" -gravity center -composite "tmpbg"

# i3lock -ni "$tmpbg"
i3lock -nti ~/m/i/wallpapers/820012.png -e

# rm $tmpbg

pkill -u "$USER" -USR2 dunst

exit 0
