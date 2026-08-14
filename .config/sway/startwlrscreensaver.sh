#!/usr/bin/env zsh

setopt SH_WORD_SPLIT NO_NOMATCH

# Basic configuration variables
ScreensaverTime="1200" # 20 minutes

# Load script for load monitors config quickly from resume
LoadConfigResume="${HOME}/.config/sway/startwlrrandr.sh"

# StateFile variable
stateFile="${HOME}/.config/sway/screen-state"

# Start/Restart nwg-wrapper
nwgWrapperRestart="${HOME}/.config/sway/nwg-wrapper-conky.sh"

# Function for sleep monitors
sleepMonitors() {
  #swaylock --color 000000 -f
  #swaymsg "output * dpms off" # Fail with new Sway version
  list_monitors=$(wlr-randr | awk '/^[A-Z]+-/ {print $1}')
  for detected_monitor in ${list_monitors} ; do
    swaymsg "output ${detected_monitor} dpms off"
  done
  echo "sleep" > ${stateFile}
}

# Function for resume monitors
resumeMonitors() {
  # swaymsg "output * dpms on"
  list_monitors=$(wlr-randr | awk '/^[A-Z]+-/ {print $1}')
  for detected_monitor in ${list_monitors} ; do
    swaymsg "output ${detected_monitor} dpms on"
  done
  # Load monitors config quickly
  #bash ${LoadConfigResume} screensaver
  echo "resume" > ${stateFile}
  # Restart nwg-wrapper
  sleep 2
  bash ${nwgWrapperRestart}
}

# Boot parameters
if [[ -z "${1}" ]] ; then
  # Kill previous process
  echo "# Trying to kill previous process"
  killall -9 swayidle 2> /dev/null
  # Init swayidle command
  sleep 3
  swayidle timeout ${ScreensaverTime} "zsh ${0} sleep" resume "zsh ${0} resume"
elif [[ "${1}" == "sleep" ]] ; then
  sleepMonitors
elif [[ "${1}" == "resume" ]] ; then
  resumeMonitors
fi

