#!/bin/bash

function update_packages() {
  sudo flatpak update
  sudo apt update
  sudo apt upgrade -y
}

function update_kernel_stable() {
  sudo apt install linux-image-amd64 -y
  sudo apt autoremove
}

function update_scripts() {
  sudo update-yazi.sh
  sudo update-vim.sh
  sudo update-rclone.sh
  sudo update-ffmpeg.sh
  sudo update-yt-dlp.sh
  sudo update-open-tv.sh
  sudo update-electronmail.sh
  sudo update-firefox.sh
  sudo update-telegram.sh
  #sudo update-tabby.sh
  #sudo update-plex.sh
}

function fstrim_run() {
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
