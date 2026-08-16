#!/usr/bin/env zsh

setopt SH_WORD_SPLIT NO_NOMATCH

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if (( $rootperm == 0 )) ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

if [[ ! -f /usr/bin/apt ]] ; then
  echo "This script is only for Debian-based systems"
  exit
fi

echo "Checking fred-tv version"
touch /etc/fredtv_version.conf
version_opentv=$(curl "https://github.com/Fredolx/open-tv/releases" 2> /dev/null | grep "releases/tag" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1 | cut -d "v" -f 2)
version_opentv_current=$(cat /etc/fredtv_version.conf)
if [[ "${version_opentv}" != "${version_opentv_current}" ]] ; then
  echo "New fred-tv version detected"
  echo "Downloading fred-tv"
  rm -rf /tmp/fred-tv.deb
  wget -q --show-progress -c "https://github.com/Fredolx/open-tv/releases/download/v${version_opentv}/Fred.TV_${version_opentv}_amd64.deb" -O /tmp/fred-tv.deb
  echo "Installing fred-tv"
  apt install /tmp/fred-tv.deb
  error_install=$?
  if (( ${error_install} == 0 )) ; then
    echo "${version_opentv}" > /etc/fredtv_version.conf
    sed -i 's/Icon\=open_tv/Icon\=me-tv/g' "/usr/share/applications/Fred TV.desktop"
  fi
else
  echo "No updates for fred-tv"
fi
