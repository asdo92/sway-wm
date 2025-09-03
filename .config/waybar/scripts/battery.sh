#!/bin/bash

detect_battery=$(upower -e | grep "battery_BAT" | head -1)
if [ ! -z "${detect_battery}" ] ; then
  battery=$(upower -i ${detect_battery} | grep -E "percentage" | awk '{print $2}')
  echo "󰁹 ${battery} "
else
  echo "󱘖  "
fi
