#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

install_neovim_gen(){
  version_download="${1}"
  echo "Downloading neovim"
  rm -rf /tmp/neovim.tar.gz
  neovim_urlfile="https://github.com/neovim/neovim/releases/download/${version_download}/nvim-linux-x86_64.tar.gz"
  wget -q --show-progress -c "${neovim_urlfile}" -O /tmp/neovim.tar.gz
  echo "Installing neovim"
  if [ -f /tmp/neovim.tar.gz ] ; then
    cd /tmp/
    tar zxf neovim.tar.gz
    rm -rf /opt/nvim
    cp -rf /tmp/nvim-linux-x86_64 /opt/nvim
    rm -rf /usr/bin/nvim
    echo '#!/bin/bash' > /usr/bin/nvim
    echo '' >> /usr/bin/nvim
    echo '/opt/nvim/bin/nvim "${@}"' >> /usr/bin/nvim
    chmod +x /usr/bin/nvim
    chmod +x /opt/nvim/bin/nvim
    unlink /usr/bin/vim
    ln -s /usr/bin/nvim /usr/bin/vim
    cp -rf /tmp/nvim-linux-x86_64/share /usr/
  fi
  rm -rf /tmp/neovim.tar.gz
  rm -rf /tmp/nvim-linux-x86_64
  echo "Installation neovim done"
}

echo "Checking neovim version"
touch /etc/neovim_version.conf
version_neovim=$(curl "https://github.com/neovim/neovim/releases" 2> /dev/null | grep "releases/tag" | grep -v "nightly" | head -1 | cut -d "=" -f 4 | cut -d "/" -f 6 | cut -d '"' -f 1)
version_neovim_current=$(cat /etc/neovim_version.conf)
if [ "${version_neovim}" != "${version_neovim_current}" ] ; then
  echo "New neovim version detected"
  install_neovim_gen "${version_neovim}"
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_neovim}" > /etc/neovim_version.conf
  fi
else
  echo "No updates for neovim"
fi
