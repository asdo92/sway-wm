#!/usr/bin/env zsh

repeat="30m"
xhost_while=0

while (( ${xhost_while} == 0 )) ; do
  xhost +
  xhost +SI:localuser:root
  sleep ${repeat}
done
