#!/bin/bash

install_telegram_gen() {
  download_url_telegram="${1}"
  echo "Downloading telegram"
  rm -rf /tmp/telegram.tar.xz
  #wget -q --show-progress -c "${download_url_telegram}" -O /tmp/telegram.tar.xz
  wget -q --show-progress -c "https://telegram.org/dl/desktop/linux" -O /tmp/telegram.tar.xz
  echo "Installing telegram"
  if [ -d /opt ] ; then
    tar Jxf /tmp/telegram.tar.xz -C /opt/
    unlink /usr/bin/telegram 2> /dev/null
    install_telegram_desktop
    ln -s /opt/Telegram/Telegram /usr/bin/telegram
    chmod +x /usr/bin/telegram
  fi
  rm -rf /tmp/telegram.tar.xz
  echo "Installation telegram done"
}

install_telegram_desktop() {
  if [ -d /usr/share/applications ] ; then
    echo '[Desktop Entry]' > /usr/share/applications/telegram.desktop
    echo 'Name=Telegram' >> /usr/share/applications/telegram.desktop
    echo 'Comment=Chat with Telegram' >> /usr/share/applications/telegram.desktop
    echo 'GenericName=Telegram' >> /usr/share/applications/telegram.desktop
    echo 'X-GNOME-FullName=Telegram' >> /usr/share/applications/telegram.desktop
    echo 'Exec=/opt/Telegram/Telegram %u' >> /usr/share/applications/telegram.desktop
    echo 'Terminal=false' >> /usr/share/applications/telegram.desktop
    echo 'X-MultipleArgs=false' >> /usr/share/applications/telegram.desktop
    echo 'Type=Application' >> /usr/share/applications/telegram.desktop
    echo 'Icon=telegram' >> /usr/share/applications/telegram.desktop
    echo 'Categories=Network;WebBrowser;' >> /usr/share/applications/telegram.desktop
    echo 'StartupWMClass=Telegram' >> /usr/share/applications/telegram.desktop
    echo 'StartupNotify=true' >> /usr/share/applications/telegram.desktop
  fi
}

echo "Checking telegram version"
touch /etc/telegram_version.conf
url_download=$(curl -I -s "https://telegram.org/dl/desktop/linux" | grep -i "location:" | cut -d " " -f 2)
version_telegram=$(basename ${url_download})
version_telegram_current=$(cat /etc/telegram_version.conf)
if [ "${version_telegram}" != "${version_telegram_current}" ] ; then
  echo "New telegram version detected"
  install_telegram_gen "${url_download}"
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_telegram}" > /etc/telegram_version.conf
  fi
else
  echo "No updates for telegram"
fi
