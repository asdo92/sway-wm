#!/bin/bash

# Variables
checkupdates_file=/tmp/checkupdates
checkupdates_run="7200" # 2 hours
listupdates_file=/tmp/listupdates
listupdates_run="60" # 1 minute
listupdates_show=/tmp/listupdates_show

# checkupdates file init
if [ ! -f ${checkupdates_file} ] ; then
  touch ${checkupdates_file}
  echo "0" > ${checkupdates_file}
else
  checkupdates_value=$(cat ${checkupdates_file})
  checkupdates_incr=$(( ${checkupdates_value} + 1))
  echo "${checkupdates_incr}" > ${checkupdates_file}
fi

# listupdates file init
if [ ! -f ${listupdates_file} ] ; then
  touch ${listupdates_file}
  echo "0" > ${listupdates_file}
else
  listupdates_value=$(cat ${listupdates_file})
  listupdates_incr=$((${listupdates_value} + 1))
  echo "${listupdates_incr}" > ${listupdates_file}
fi
if [ ! -f ${listupdates_show} ] ; then
  touch ${listupdates_show}
  echo "0" > ${listupdates_show}
fi

# Check updates on Arch Linux
checkupdate=$(cat ${checkupdates_file})
listupdate=$(cat ${listupdates_file})
if [ -f /usr/bin/pacman ] ; then
  if [ ${checkupdate} -ge ${checkupdates_run} ] ; then
    sudo -A pacman -Syy > /dev/null 2>&1
    echo "0" > ${checkupdates_file}
  fi
  if [ ${listupdate} -ge ${listupdates_run} ] ; then
    num_packages=$(pacman -Qu | wc -l)
    echo "${num_packages}" > ${listupdates_show}
  fi
  echo " $(cat ${listupdates_show}) "
# Check updates on Ubuntu/Debian/Devuan
elif [ -f /usr/bin/apt ] ; then
  if [ ${checkupdate} -ge ${checkupdates_run} ] ; then
    sudo -A apt update > /dev/null 2>&1
    echo "0" > ${checkupdates_file}
  fi
  if [ ${listupdate} -ge ${listupdates_run} ] ; then
    num_packages=$(apt list --upgradable 2>/dev/null | grep -c ^)
    num_packages=$(expr ${num_packages} - 1)
    echo "${num_packages}" > ${listupdates_show}
  fi
  echo " $(cat ${listupdates_show}) "
# Disable for other distros
else 
  echo " 0 "
fi
