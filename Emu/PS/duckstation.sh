#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
/mnt/SDCARD/System/usr/miyoo/scripts/cpufreq.sh performance 4 7

cd $RA_DIR/

if ! find "/mnt/SDCARD/BIOS" -maxdepth 1 -iname "scph*" -o -iname "psxonpsp660.bin" -o -iname "ps*.bin" | grep -q .; then
	/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i bg-exit.png -m "No bios found, DuckStation will probably not work." -k " "
fi


HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v -L $RA_DIR/.retroarch/cores/duckstation_libretro.so "$@"
