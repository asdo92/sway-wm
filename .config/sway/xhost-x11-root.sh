#!/bin/bash

repeat="30m"
xhost_while=0

while [ ${xhost_while} -eq 0 ] ; do
  xhost +
  xhost +SI:localuser:root
  sleep ${repeat}
done
