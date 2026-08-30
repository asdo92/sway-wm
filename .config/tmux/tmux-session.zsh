#!/usr/bin/env zsh

# Set windows session
tmux new-session -d -s work -n "#{client_tty}"
tmux new-window -t work:1 -n "#{client_tty}"
tmux new-window -t work:2 -n "#{client_tty}"
tmux new-window -t work:3 -n "#{client_tty}"
tmux new-window -t work:4 -n "#{client_tty}"
tmux new-window -t work:5 -n ssmtunel
tmux new-window -t work:6 -n lan-100 \
  'echo lan100 ; /usr/bin/zsh'
tmux new-window -t work:7 -n lan-50 \
  'echo lan50 ; /usr/bin/zsh'
tmux attach-session -t work
