#!/bin/bash

## Script To Manage Speaker Volume

# Get Volume
get_volume() {
	volume=$(amixer get Master | tail -n1 | awk -F ' ' '{print $5}' | tr -d '[]')
	echo "$volume"
}

# Get icons
get_icon() {
	vol="$(get_volume)"
	current="${vol%%%}"
	if [[ "$current" -eq "0" ]]; then
		icon='/usr/share/icons/breeze-dark/status/16/audio-volume-muted.svg'
	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
		icon='/usr/share/icons/breeze-dark/status/16/audio-volume-low.svg'
	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
		icon='/usr/share/icons/breeze-dark/status/16/audio-volume-medium.svg'
	elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
		icon='/usr/share/icons/breeze-dark/status/16/audio-volume-high.svg'
	fi
}

# Increase Volume
up_volume() {
	amixer -Mq set Master,0 5%+ unmute && get_icon && notify-send -u low  -i "$icon" "Volume : $(get_volume)"
}

# Decrease Volume
down_volume() {
	amixer -Mq set Master,0 5%- unmute && get_icon && notify-send -u low  -i "$icon" "Volume : $(get_volume)"
}

# Toggle Mute
toggle_mute() {
    status=$(amixer get Master | tail -n1 | grep -wo 'on')

	if [[ "$status" == "on" ]]; then
		amixer set Master toggle && notify-send -u low  -i "/usr/share/icons/breeze-dark/status/16/audio-volume-muted.svg" "Mute"
	else
		amixer set Master toggle && get_icon && notify-send -u low  -i "$icon" "Unmute"
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--up" ]]; then
	up_volume
elif [[ "$1" == "--down" ]]; then
        down_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
else
	get_volume
fi
