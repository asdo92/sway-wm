#!/bin/bash

status_bar=0

while [ ${status_bar} -eq 0 ] ; do
  updates=$(~/.config/sway/scripts/checkUpdates.sh)
  kernel=$(~/.config/sway/scripts/kernel_version.sh)
  cpuinfo=$(~/.config/sway/scripts/cpu_info.sh)
  meminfo=$(~/.config/sway/scripts/mem_info.sh)
  volume=$(~/.config/sway/scripts/get_volume.sh)
  date=$(~/.config/sway/scripts/current_date.sh)
  echo "${updates} ${kernel} ${cpuinfo} ${meminfo} ${volume} ${date}"
  sleep 2
done
