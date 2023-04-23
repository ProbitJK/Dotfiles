#!/bin/bash

ps -e | rg -N --color never swaybg | awk '{print $1}' | xargs kill

swaybg -i $(fd -t f . /home/probit/Pictures/wallpapers/ | shuf -n 1) -m fill &
