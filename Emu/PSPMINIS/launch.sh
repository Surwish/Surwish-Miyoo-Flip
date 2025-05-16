#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh ondemand 3 6

export SDL_AUDIODRIVER=dsp
HOME=$PWD ./PPSSPPSDL "$*"
