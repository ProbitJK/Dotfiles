#!/bin/bash
WALLDIR="/home/probitjk/Pictures/wallpapers/"
WP=$(find "$WALLDIR" -type f | shuf -n 1)
# hyprctl hyprpaper reload "eDP-1,$WP"
ps -e | rg -N --color never swaybg | awk '{print $1}' | xargs kill
swaybg -i $WP -m fit
