#!/bin/bash

install_firefox_gen() {
  download_url_firefox="${1}"
  echo "Downloading firefox"
  rm -rf /tmp/firefox.tar.xz
  #wget -q --show-progress -c "${download_url_firefox}" -O /tmp/firefox.tar.xz
  wget -q --show-progress -c "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" -O /tmp/firefox.tar.xz
  echo "Installing firefox"
  if [ -d /usr/lib ] ; then
    tar Jxf /tmp/firefox.tar.xz -C /usr/lib/
    unlink /usr/bin/firefox 2> /dev/null
    install_firefox_desktop
    ln -s /usr/lib/firefox/firefox /usr/bin/firefox
    chmod +x /usr/bin/firefox
  fi
  rm -rf /tmp/firefox.tar.xz
  echo "Installation firefox done"
}

install_firefox_desktop() {
  if [ -d /usr/share/applications ] ; then
    echo '[Desktop Entry]' > /usr/share/applications/firefox.desktop
    echo 'Name=Firefox' >> /usr/share/applications/firefox.desktop
    echo 'Comment=Browse the World Wide Web' >> /usr/share/applications/firefox.desktop
    echo 'GenericName=Web Browser' >> /usr/share/applications/firefox.desktop
    echo 'X-GNOME-FullName=Firefox Web Browser' >> /usr/share/applications/firefox.desktop
    echo 'Exec=/usr/lib/firefox/firefox-bin %u' >> /usr/share/applications/firefox.desktop
    echo 'Terminal=false' >> /usr/share/applications/firefox.desktop
    echo 'X-MultipleArgs=false' >> /usr/share/applications/firefox.desktop
    echo 'Type=Application' >> /usr/share/applications/firefox.desktop
    if [ -f /usr/lib/firefox/browser/chrome/icons/default/default48.png ] ; then
      echo 'Icon=/usr/lib/firefox/browser/chrome/icons/default/default48.png' >> /usr/share/applications/firefox.desktop
    else
      echo 'Icon=firefox' >> /usr/share/applications/firefox.desktop
    fi
    echo 'Categories=Network;WebBrowser;' >> /usr/share/applications/firefox.desktop
    echo 'MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;' >> /usr/share/applications/firefox.desktop
    echo 'StartupWMClass=Firefox' >> /usr/share/applications/firefox.desktop
    echo 'StartupNotify=true' >> /usr/share/applications/firefox.desktop
  fi
}

echo "Checking firefox version"
touch /etc/firefox_version.conf
url_download=$(curl -I -s "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" | grep -i "location:" | cut -d " " -f 2)
version_firefox=$(basename ${url_download})
version_firefox_current=$(cat /etc/firefox_version.conf)
if [ "${version_firefox}" != "${version_firefox_current}" ] ; then
  echo "New firefox version detected"
  install_firefox_gen "${url_download}"
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_firefox}" > /etc/firefox_version.conf
  fi
else
  echo "No updates for firefox"
fi
