#!/bin/bash

mkdir -p /etc/root 2> /dev/null
rootperm=$?
if [ $rootperm -eq 0 ] ; then
  rm -rf /etc/root
else
  echo "Root permission is required to run this script"
  exit
fi

install_ffmpeg_gen(){
  echo "Downloading ffmpeg"
  rm -rf /tmp/ffmpeg.tar.xz
  wget -q --show-progress -c "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linux64-gpl.tar.xz" -O /tmp/ffmpeg.tar.xz
  echo "Installing ffmpeg"
  tar Jxf /tmp/ffmpeg.tar.xz -C /tmp/
  if [ -f /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg ] ; then
    cp -rf /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg /usr/bin/
    chmod +x /usr/bin/ffmpeg
  fi
  if [ -f /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffprobe ] ; then
    cp -rf /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffprobe /usr/bin/
    chmod +x /usr/bin/ffprobe
  fi
  if [ -f /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffplay ] ; then
    cp -rf /tmp/ffmpeg-master-latest-linux64-gpl/bin/ffplay /usr/bin/
    chmod +x /usr/bin/ffplay
  fi
  if [ -d /tmp/ffmpeg-master-latest-linux64-gpl/man ] ; then
    cp -rf /tmp/ffmpeg-master-latest-linux64-gpl/man/* /usr/share/man/
  fi
  rm -rf /tmp/ffmpeg.tar.xz
  rm -rf /tmp/ffmpeg-master-latest-linux64-gpl
  echo "Installation ffmpeg done"
}

install_alias_ffmpeg() {
  ffmpeg -hide_banner -version &> /dev/null
  error_banner=$?
  if [ ${error_banner} -eq 0 ] ; then
    echo "#!/bin/bash" > /etc/profile.d/ffmpeg.sh
    echo "" >> /etc/profile.d/ffmpeg.sh
    echo 'alias ffmpeg="ffmpeg -hide_banner"' >> /etc/profile.d/ffmpeg.sh
    export alias ffmpeg="ffmpeg -hide_banner"
    chmod +x /etc/profile.d/ffmpeg.sh
  else
    rm -rf /etc/profile.d/ffmpeg-hide-banner.sh
  fi
}

echo "Checking ffmpeg version"
touch /etc/ffmpeg_version.conf
version_ffmpeg=$(curl "https://github.com/BtbN/FFmpeg-Builds/releases/tag/latest" 2> /dev/null | grep "<title>" | cut -d ">" -f 2 | cut -d "<" -f 1)
version_ffmpeg_current=$(cat /etc/ffmpeg_version.conf)
if [ "${version_ffmpeg}" != "${version_ffmpeg_current}" ] ; then
  echo "New ffmpeg version detected"
  install_ffmpeg_gen
  error_install=$?
  if [ ${error_install} -eq 0 ] ; then
    echo "${version_ffmpeg}" > /etc/ffmpeg_version.conf
    install_alias_ffmpeg
  fi
else
  echo "No updates for ffmpeg"
fi
