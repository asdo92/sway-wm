#!/bin/bash

# Variables
checkupdates_file=/tmp/checkupdates
checkupdates_run="7200" # 2 hours

# checkupdates file init
if [ ! -f ${checkupdates_file} ] ; then
  touch ${checkupdates_file}
  echo "0" > ${checkupdates_file}
else
  checkupdates_value=$(cat ${checkupdates_file})
  checkupdates_incr=$(expr ${checkupdates_value} + 1)
  echo "${checkupdates_incr}" > ${checkupdates_file}
fi

# Check updates on Arch Linux
checkupdate=$(cat ${checkupdates_file})
if [ -f /usr/bin/pacman ] ; then
  if [ ${checkupdate} -ge ${checkupdates_run} ] ; then
    sudo -A pacman -Syy > /dev/null 2>&1
    echo "0" > ${checkupdates_file}
  fi
  num_packages=$(pacman -Qu | wc -l)
	echo " ${num_packages} "
# Check updates on Ubuntu/Debian/Devuan
elif [ -f /usr/bin/apt ] ; then
  if [ ${checkupdate} -ge ${checkupdates_run} ] ; then
    sudo -A apt-get update > /dev/null 2>&1
    echo "0" > ${checkupdates_file}
  fi
  num_packages=$(apt list --upgradable 2>/dev/null | grep -c ^)
  num_packages=$(expr ${num_packages} - 1)
	echo " ${num_packages} "
# Disable for other distros
else 
  echo " 0 "
fi
