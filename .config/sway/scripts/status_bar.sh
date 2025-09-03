#!/bin/bash

status_bar=0

while [ ${status_bar} -eq 0 ] ; do
  updates=$(~/.config/sway/scripts/checkUpdates.sh)
  kernel=$(~/.config/sway/scripts/kernel_version.sh)
  cpuinfo=$(~/.config/sway/scripts/cpu_info.sh)
  meminfo=$(~/.config/sway/scripts/mem_info.sh)
  volume=$(~/.config/sway/scripts/get_volume.sh)
  lang=$(~/.config/sway/scripts/get_lang.sh)
  battery=$(~/.config/sway/scripts/battery.sh)
  date=$(~/.config/sway/scripts/current_date.sh)
  echo "${updates} ${kernel} ${cpuinfo} ${meminfo} ${volume} ${lang} ${battery} ${date}"
  sleep 2
done
