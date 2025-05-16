#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh ondemand 2 6

cd $RA_DIR/
echo "--------------------------------------------------------------------------------------------------------"
HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v -L $RA_DIR/.retroarch/cores/bluemsx_libretro.so "$@" 

