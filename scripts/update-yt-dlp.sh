#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

echo "Checking yt-dlp version"
touch /etc/ytdlp_version.conf
version_ytdlp=$(curl "https://github.com/yt-dlp/yt-dlp/releases" 2> /dev/null | grep "releases/tag" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1 | cut -d "v" -f 2)
version_ytdlp_current=$(cat /etc/ytdlp_version.conf)
if [ "${version_ytdlp}" != "${version_ytdlp_current}" ] ; then
  echo "New yt-dlp version detected"
  echo "Downloading yt-dlp"
  rm -rf /tmp/yt-dlp
  wget -q --show-progress -c "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux" -O /tmp/yt-dlp
  echo "Installing yt-dlp"
  cp -rf /tmp/yt-dlp /usr/bin/
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_ytdlp}" > /etc/ytdlp_version.conf
    chmod +x /usr/bin/yt-dlp
    echo "Installation yt-dlp done"
  fi
else
  echo "No updates for yt-dlp"
fi
