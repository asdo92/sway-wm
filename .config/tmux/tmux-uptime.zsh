#!/usr/bin/env zsh

# tmux uptime info
awk '{
    total = int($1)
    days = int(total / 86400)
    hours = int(total / 3600) % 24
    minutes = int(total / 60) % 60

    if (days > 0)
        printf "%dd %dh\n", days, hours
    else if (hours > 0)
        printf "%dh %dm\n", hours, minutes
    else
        printf "%dm\n", minutes
}' /proc/uptime
