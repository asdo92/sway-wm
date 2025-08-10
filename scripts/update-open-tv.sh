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

echo "Checking open-tv version"
touch /etc/opentv_version.conf
version_opentv=$(curl "https://github.com/Fredolx/open-tv/releases" 2> /dev/null | grep "releases/tag" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1 | cut -d "v" -f 2)
version_opentv_current=$(cat /etc/opentv_version.conf)
if [ "${version_opentv}" != "${version_opentv_current}" ] ; then
  echo "New open-tv version detected"
  echo "Downloading open-tv"
  rm -rf /tmp/open-tv.deb
  wget -q --show-progress -c "https://github.com/Fredolx/open-tv/releases/download/v${version_opentv}/Open.TV_${version_opentv}_amd64.deb" -O /tmp/open-tv.deb
  echo "Installing open-tv"
  apt install /tmp/open-tv.deb
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_opentv}" > /etc/opentv_version.conf
    sed -i 's/Icon\=open_tv/Icon\=me-tv/g' "/usr/share/applications/Open TV.desktop"
  fi
else
  echo "No updates for open-tv"
fi
