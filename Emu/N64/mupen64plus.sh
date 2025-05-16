#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh performance 4 7

read -r device_type </tmp/device_type
if [ "$device_type" = "brick" ]; then
	touch "/tmp/trimui_inputd/input_dpad_to_joystick"
fi

cd $RA_DIR/

HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v -L $RA_DIR/.retroarch/cores/mupen64plus_libretro.so "$@"

rm -f "/tmp/trimui_inputd/input_dpad_to_joystick"
