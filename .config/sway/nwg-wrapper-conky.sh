#!/bin/bash

# Stop previous process
killall nwg-wrapper

# Sleep 1s
sleep 1

# Start new process
nwg-wrapper -s conky_sway.sh -r 2000 -p right -mr 15 -mt 10 -mb 80 &

# Example if you want show alwsays nwg-wrapper in one monitor
#nwg-wrapper -s conky_sway.sh -r 2000 -p right -mr 15 -mt 10 -mb 80 -o HDMI-A-1 &
