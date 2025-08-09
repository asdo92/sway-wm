#!/bin/bash

# Variables
listupdates_file=/tmp/listupdates
listupdates_show=/tmp/listupdates_show

# listupdates file init
if [ ! -f ${listupdates_file} ] ; then
  touch ${listupdates_file}
  echo "0" > ${listupdates_file}
fi
if [ ! -f ${listupdates_show} ] ; then
  touch ${listupdates_show}
  echo "0" > ${listupdates_show}
fi

# Check updates on Arch Linux
if [ -f /usr/bin/pacman ] ; then
  echo "$(cat ${listupdates_show}) "
# Check updates on Ubuntu/Debian/Devuan
elif [ -f /usr/bin/apt ] ; then
  echo "$(cat ${listupdates_show}) "
# Disable for other distros
else 
  echo "0 "
fi
