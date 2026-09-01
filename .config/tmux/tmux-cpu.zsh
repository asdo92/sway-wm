#!/usr/bin/env zsh

# tmux cpu info
cpuPercentage=$(top -b -n1 | grep \%Cpu | awk '{print 100-$8}')
echo "${cpuPercentage}%"
