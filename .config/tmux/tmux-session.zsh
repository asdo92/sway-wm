#!/usr/bin/env zsh

# Set windows session
tmux new-session -d -s work -n terminal1
tmux new-window -t work:1 -n terminal2
tmux new-window -t work:2 -n terminal3
tmux new-window -t work:3 -n terminal4
tmux new-window -t work:4 -n terminal5
tmux new-window -t work:5 -n ssmtunel
tmux new-window -t work:6 -n lan-100
tmux new-window -t work:7 -n lan-50
tmux attach-session -t work
