#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh ondemand 2 6

cd $RA_DIR/

HOME=$RA_DIR/ $RA_DIR/ra64.miyoo-1.18 -v -L $RA_DIR/.retroarch/cores/mame2003_plus_libretro.so "$@"
