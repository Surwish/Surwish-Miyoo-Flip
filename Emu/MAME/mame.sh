#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh ondemand 2 7

cd $RA_DIR/

# required to load this Mame 0.259 (require "libFLAC.so.8")
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/SDCARD/System/lib

HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v -L $RA_DIR/.retroarch/cores/mame_libretro.so "$@"
