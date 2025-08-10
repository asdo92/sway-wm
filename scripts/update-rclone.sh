#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

if [ ! -f /usr/bin/apt ] ; then
  echo "This script is only for Debian-based systems"
  exit
fi

echo "Checking rclone version"
touch /etc/rclone_version.conf
version_rclone=$(curl "https://rclone.org/downloads/" 2> /dev/null | grep "\"release\"" | cut -d ">" -f 2 | cut -d "<" -f 1)
version_rclone_current=$(cat /etc/rclone_version.conf)
if [ "${version_rclone}" != "${version_rclone_current}" ] ; then
  echo "New rclone version detected"
  echo "Downloading rclone"
  rm -rf /tmp/rclone.deb
  wget -q --show-progress -c "https://downloads.rclone.org/rclone-current-linux-amd64.deb" -O /tmp/rclone.deb
  echo "Installing rclone"
  apt install /tmp/rclone.deb
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_rclone}" > /etc/rclone_version.conf
  fi
else
  echo "No updates for rclone"
fi
