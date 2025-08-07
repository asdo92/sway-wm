#!/bin/bash

install_vim_gen(){
  version_download="${1}"
  echo "Downloading vim"
  rm -rf /tmp/vim.appimage
  vim_urlfile=$(curl -L "https://github.com/vim/vim-appimage/releases/tag/${version_download}" 2> /dev/null | grep "/Vim-${version_download}" | grep "href\=" | cut -d "=" -f 2 | cut -d '"' -f 2)
  wget -q --show-progress -c "${vim_urlfile}" -O /tmp/vim.appimage
  echo "Installing vim"
  if [ -f /tmp/vim.appimage ] ; then
    cp -rf /tmp/vim.appimage /usr/bin/vim
    chmod +x /usr/bin/vim
  fi
  rm -rf /tmp/vim.appimage
  echo "Installation vim done"
}

echo "Checking vim version"
touch /etc/vim_version.conf
version_vim=$(curl "https://github.com/vim/vim-appimage/releases" 2> /dev/null | grep "releases/tag" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1)
version_vim_current=$(cat /etc/vim_version.conf)
if [ "${version_vim}" != "${version_vim_current}" ] ; then
  echo "New vim version detected"
  install_vim_gen "${version_vim}"
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_vim}" > /etc/vim_version.conf
  fi
else
  echo "No updates for vim"
fi
