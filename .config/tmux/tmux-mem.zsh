#!/usr/bin/env zsh

# tmux mem info
free | awk '/^Mem:/ {
    printf "%.0f%%\n", ($3 / $2) * 100
}'
