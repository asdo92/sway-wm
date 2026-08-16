#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

echo "Checking rclone version"
touch /etc/rclone_version.conf
version_rclone=$(curl "https://rclone.org/downloads/" 2> /dev/null | grep "\"release\"" | cut -d ">" -f 2 | cut -d "<" -f 1 | cut -d " " -f 2)
version_rclone_current=$(cat /etc/rclone_version.conf)
if [ "${version_rclone}" != "${version_rclone_current}" ] ; then
  echo "New rclone version detected"
  echo "Downloading rclone"
  rm -rf /tmp/rclone.zip
  wget -q --show-progress -c "https://downloads.rclone.org/${version_rclone}/rclone-${version_rclone}-linux-amd64.zip" -O /tmp/rclone.zip
  echo "Installing rclone"
  cd /tmp
  unzip -q rclone.zip
  cp -rf rclone-${version_rclone}-linux-amd64/rclone /usr/bin/rclone
  chmod +x /usr/bin/rclone
  mkdir -p /usr/share/man/man1/
  cp -rf rclone-${version_rclone}-linux-amd64/rclone.1 /usr/share/man/man1/
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_rclone}" > /etc/rclone_version.conf
    rm -rf /tmp/rclone.zip
    rm -rf /tmp/rclone-${version_rclone}-linux-amd64
    echo "Installation rclone done"
  fi
else
  echo "No updates for rclone"
fi
