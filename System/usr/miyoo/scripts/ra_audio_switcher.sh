#!/bin/sh

if [ -f "/tmp/btdev_addr" ]; then
    echo "Bluetooth in use: Retroarch audio driver set to alsa"
    /mnt/SDCARD/System/usr/miyoo/scripts/set_ra_cfg.sh "/mnt/SDCARD/RetroArch/ra64.miyoo.cfg" "audio_driver" "alsa"
else
    echo "Bluetooth not in use: Retroarch audio driver set to oss"
    /mnt/SDCARD/System/usr/miyoo/scripts/set_ra_cfg.sh "/mnt/SDCARD/RetroArch/ra64.miyoo.cfg" "audio_driver" "oss"
fi
