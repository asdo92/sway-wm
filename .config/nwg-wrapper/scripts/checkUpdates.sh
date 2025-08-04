#!/bin/bash

# Check updates on Arch Linux
if [ -f /usr/bin/pacman ] ; then
  num_packages=$(pacman -Qu | wc -l)
	echo " ${num_packages} "
# Check updates on Ubuntu/Debian/Devuan
elif [ -f /usr/bin/apt ] ; then
  num_packages=$(apt list --upgradable 2>/dev/null | grep -c ^)
  num_packages=$(expr ${num_packages} - 1)
	echo " ${num_packages} "
# Disable for other distros
else 
  echo " 0 "
fi
