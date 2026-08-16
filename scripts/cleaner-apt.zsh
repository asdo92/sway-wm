#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

  function printf(){
  echo "$1" "$2"
  }

  ls /root/ > /dev/null
  if [ "$?" -eq 0 ] ; then
  printf "Root -> OK"
  else
    if [ $USER != root ]; then
      clear
      printf ""
      printf "Error: must be root"
      printf "Exiting..."
      printf ""
     exit 0
    fi
  fi

printf "Cleaning apt cache..."
apt clean

printf "Removing old config files..."
apt purge $OLDCONF

#printf "Removing old kernels..."
#aptitude purge $OLDKERNELS

printf "Emptying every trashes..."
rm -rfv /home/*/.local/share/Trash/*/**
rm -rfv /root/.local/share/Trash/*/**

printf "Script Finished!"
