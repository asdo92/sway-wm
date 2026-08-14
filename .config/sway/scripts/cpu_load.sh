#!/usr/bin/env zsh

# Script to show cpu
# Created by dmesg00 (dmesg00@duck.com)
# Licensed by GPL v.2
# Date: 10-01-2020
# --------------------------------------
VERSION="1.0"


# Variables
cpuPercentage=$(top -b -n1 | grep \%Cpu | awk '{print 100-$8}')
showCpuPercentage=$(echo ${cpuPercentage})
showCpuPercentageInteger=$(echo ${showCpuPercentage} | sed 's/,/./g' |cut -d "." -f 1)

# Show percentage bar
if (( ${showCpuPercentageInteger} >= 0 )) ; then
	showCpuPercentageBar="="
fi
if (( ${showCpuPercentageInteger} >= 3 )) ; then
	showCpuPercentageBar="=="
fi
if (( ${showCpuPercentageInteger} >= 12 )) ; then
	showCpuPercentageBar="==="
fi
if (( ${showCpuPercentageInteger} >= 18 )) ; then
	showCpuPercentageBar="===="
fi
if (( ${showCpuPercentageInteger} >= 25 )) ; then
	showCpuPercentageBar="====="
fi
if (( ${showCpuPercentageInteger} >= 35 )) ; then
	showCpuPercentageBar="======"
fi
if (( ${showCpuPercentageInteger} >= 40 )) ; then
	showCpuPercentageBar="======="
fi
if (( ${showCpuPercentageInteger} >= 45 )) ; then
	showCpuPercentageBar="========"
fi
if (( ${showCpuPercentageInteger} >= 50 )) ; then
	showCpuPercentageBar="=========="
fi
if (( ${showCpuPercentageInteger} >= 62 )) ; then
	showCpuPercentageBar="============="
fi
if (( ${showCpuPercentageInteger} >= 75 )) ; then
	showCpuPercentageBar="==============="
fi
if (( ${showCpuPercentageInteger} >= 85 )) ; then
	showCpuPercentageBar="================="
fi
if (( ${showCpuPercentageInteger} >= 90 )) ; then
	showCpuPercentageBar="=================="
fi
if (( ${showCpuPercentageInteger} >= 95 )) ; then
	showCpuPercentageBar="==================="
fi
if (( ${showCpuPercentageInteger} >= 100 )) ; then
	showCpuPercentageBar="===================="
fi

# Show results
if [[ "$1" == "-p" ]] ; then
	echo ${showCpuPercentage}%
elif [[ "$1" == "-b" ]] ; then
	echo ${showCpuPercentageBar}
else
	echo ""
	echo " cpuinfo v$VERSION"
	echo " ------------"
	echo ""
	echo " CpuPercentage Use:"
	echo " ${showCpuPercentageBar} ${showCpuPercentage}%"
	echo ""
	echo " Available commands:"
	echo ""
	echo " cpuinfo.sh -p | Show CpuPercentage"
	echo " cpuinfo.sh -b | Show CpuPercentage Bar"
	echo ""
	echo " Note: Conky require 'maximum_width = 240'"
	echo ""
fi
