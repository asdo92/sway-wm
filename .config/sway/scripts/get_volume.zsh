#!/usr/bin/env zsh

#get_volume=$(amixer | grep "%" | head -1 | cut -d "%" -f 1 | cut -d "[" -f 2)
get_volume=$(pactl list sinks | grep "Volume:" | head -1 | awk '{print $5}')
echo " ${get_volume} "
