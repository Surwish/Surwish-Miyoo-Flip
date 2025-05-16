#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh ondemand 3 6

Rom="$@"
RomPath=$(dirname "$1")
RomDir=$(basename "$RomPath")
romName=$(basename "$@")
romNameNoExtension=${romName%.*}

if [ "$romNameNoExtension" = "° Run Splore" ]; then
	sh "/mnt/SDCARD/Emus/PICO/Pico8 Wrapper - Splore.sh"
	exit
fi


cd $RA_DIR/

HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v -L $RA_DIR/.retroarch/cores/fake08_libretro.so "$@"
