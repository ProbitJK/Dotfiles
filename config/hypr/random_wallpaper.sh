#!/bin/bash
WALLDIR="/home/probit/Pictures/Wallpaper/"
WP=$(find "$WALLDIR" -type f | shuf -n 1)
hyprctl hyprpaper reload "eDP-1,$WP"
