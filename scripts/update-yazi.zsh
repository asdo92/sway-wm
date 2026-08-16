#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

install_yazi_gen(){
  version_download="${1}"
  echo "Downloading yazi"
  rm -rf /tmp/yazi.zip
  wget -q --show-progress -c "https://github.com/sxyazi/yazi/releases/download/${version_download}/yazi-x86_64-unknown-linux-musl.zip" -O /tmp/yazi.zip
  echo "Installing yazi"
  cd /tmp
  unzip -q yazi.zip
  if [ -f yazi-x86_64-unknown-linux-musl/ya ] ; then
    cp -rf yazi-x86_64-unknown-linux-musl/ya /usr/bin/
    chmod +x /usr/bin/ya
  fi
  if [ -f yazi-x86_64-unknown-linux-musl/yazi ] ; then
    cp -rf yazi-x86_64-unknown-linux-musl/yazi /usr/bin/
    chmod +x /usr/bin/yazi
  fi
  rm -rf /tmp/yazi.zip
  rm -rf /tmp/yazi-x86_64-unknown-linux-musl
  echo "Installation yazi done"
}

echo "Checking yazi version"
touch /etc/yazi_version.conf
version_yazi=$(curl "https://github.com/sxyazi/yazi/releases" 2> /dev/null | grep "releases/tag" | grep -v "nightly" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1)
version_yazi_current=$(cat /etc/yazi_version.conf)
if [ "${version_yazi}" != "${version_yazi_current}" ] ; then
  echo "New yazi version detected"
  install_yazi_gen "${version_yazi}"
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_yazi}" > /etc/yazi_version.conf
  fi
else
  echo "No updates for yazi"
fi
