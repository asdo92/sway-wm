#!/usr/bin/env zsh

status_bar=0

while (( ${status_bar} == 0 )) ; do
  updates=$(~/.config/sway/scripts/checkUpdates.zsh)
  kernel=$(~/.config/sway/scripts/kernel_version.zsh)
  cpuinfo=$(~/.config/sway/scripts/cpu_info.zsh)
  meminfo=$(~/.config/sway/scripts/mem_info.zsh)
  volume=$(~/.config/sway/scripts/get_volume.zsh)
  lang=$(~/.config/sway/scripts/get_lang.zsh)
  battery=$(~/.config/sway/scripts/battery.zsh)
  date=$(~/.config/sway/scripts/current_date.zsh)
  echo "${updates} ${kernel} ${cpuinfo} ${meminfo} ${volume} ${lang} ${battery} ${date}"
  sleep 2
done
