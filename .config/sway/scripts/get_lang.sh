#!/bin/bash

sway_config="${HOME}/.config/sway/config"

if [ -f ${sway_config} ] ; then
  get_lang=$(cat ${sway_config} | grep xkb_layout | grep -v "#" | head -1 | sed 's/xkb_layout//g' | cut -d '"' -f 2)
  if [ -z ${get_lang} ] ; then
    echo "  us "
  else
    echo "  ${get_lang} "
  fi
else
  echo "  us "
fi
