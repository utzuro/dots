#!/usr/bin/env bash

#swww-daemon &> /dev/null

EXTERNAL_DISK="/mnt/seance"
IMAGE_DIR="mysticism/img/walls"

if [ -d "$EXTERNAL_DISK" ]; then
    WALLS_DIR="$EXTERNAL_DISK/$IMAGE_DIR"
else
    WALLS_DIR="$HOME/$IMAGE_DIR"
fi

if [ ! -d "$WALLS_DIR" ]; then
    echo "Directory $WALLS_DIR does not exist."
    exit 1
fi

while true; do
    WALL=$(find "$WALLS_DIR" -type f | shuf -n 1)
    swww img "$WALL" --transition-type random --transition-duration 2s --transition-fps 60
    sleep 10m
done
