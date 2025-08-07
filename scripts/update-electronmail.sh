#!/bin/bash

echo "Checking electronmail version"
touch /etc/electronmail_version.conf
version_electronmail=$(curl "https://github.com/vladimiry/ElectronMail/releases" 2> /dev/null | grep "releases/tag" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1 | cut -d "v" -f 2)
version_electronmail_current=$(cat /etc/electronmail_version.conf)
if [ "${version_electronmail}" != "${version_electronmail_current}" ] ; then
  echo "New electronmail version detected"
  echo "Downloading electronmail"
  rm -rf /tmp/electronmail.deb
  wget -q --show-progress -c "https://github.com/vladimiry/ElectronMail/releases/download/v${version_electronmail}/electron-mail-${version_electronmail}-linux-amd64.deb" -O /tmp/electronmail.deb
  echo "Installing electronmail"
  apt install /tmp/electronmail.deb
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_electronmail}" > /etc/electronmail_version.conf
  fi
else
  echo "No updates for electronmail"
fi
