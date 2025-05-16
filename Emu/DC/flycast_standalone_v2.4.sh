#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
cpufreq.sh performance 7 7

# cwd is EMU_DIR
cd /mnt/SDCARD/Emu/DC/flycast_v2.4/

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/mnt/SDCARD/Emu/DC/flycast_v2.4/lib"
export FLYCAST_BIOS_DIR="/mnt/SDCARD/BIOS/dc/"
export FLYCAST_DATA_DIR="$FLYCAST_BIOS_DIR"
export FLYCAST_CONFIG_DIR="/mnt/SDCARD/Emu/DC/flycast_v2.4/config/"
export HOME="/mnt/SDCARD/Emu/DC/flycast_v2.4"
export XDG_DATA_HOME="$FLYCAST_BIOS_DIR"
export XDG_CONFIG_HOME="/mnt/SDCARD/Emu/DC/flycast_v2.4/config/"

mkdir -p "$FLYCAST_BIOS_DIR/flycast"

./flycast "$@"
