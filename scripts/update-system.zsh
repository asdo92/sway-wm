#!/usr/bin/env zsh

update_packages() {
  sudo flatpak update
  sudo apt update
  sudo apt upgrade -y
}

update_kernel_stable() {
  sudo apt install linux-image-amd64 -y
  sudo apt autoremove
}

update_scripts() {
  sudo update-yazi.zsh
  sudo update-vim.zsh
  sudo update-rclone.zsh
  sudo update-ffmpeg.zsh
  sudo update-yt-dlp.zsh
  sudo update-open-tv.zsh
  sudo update-electronmail.zsh
  sudo update-firefox.zsh
  sudo update-telegram.zsh
  #sudo update-tabby.sh
  #sudo update-plex.sh
}

fstrim_run() {
  echo "First Trimming"
  sudo /sbin/fstrim -a -v
  echo "Second Trimming"
  sudo /sbin/fstrim -a -v
  echo "Third Trimming"
  sudo /sbin/fstrim -a -v
}

update_scripts
update_packages
update_kernel_stable
fstrim_run
