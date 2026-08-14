#!/usr/bin/zsh

df -h / | awk '/\//{ printf(" %4s / %s \n", $4, $2) }'
