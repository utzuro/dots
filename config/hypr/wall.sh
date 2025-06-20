#!/usr/bin/env bash

swww-daemon &> /dev/null &!

EXTERNAL_DISK="/mnt/seance/mysticism"
EXTERNAL_ALT="/mnt/zalot/mysticism"
HOME_DIR="$HOME/mysticism"
IMAGE_DIR="i/walls"

if [ -d "$EXTERNAL_DISK" ]; then
    WALLS_DIR="$EXTERNAL_DISK/$IMAGE_DIR"
elif [ -d "$EXTERNAL_ALT" ]; then
    WALLS_DIR="$EXTERNAL_ALT/$IMAGE_DIR"
elif [ -d "$HOME_DIR/$IMAGE_DIR" ]; then
    WALLS_DIR="$HOME_DIR/$IMAGE_DIR"
else
    echo "No valid image directory found. Please check your external disks or home directory."
    exit 1
fi

if [ ! -d "$WALLS_DIR" ]; then
    echo "Directory $WALLS_DIR does not exist."
    exit 1
fi

while true; do
    WALL=$(find "$WALLS_DIR" -type f | shuf -n 1)
    swww img "$WALL" --transition-step 180 --transition-fps 60 --transition-type center
    sleep 30m
done
