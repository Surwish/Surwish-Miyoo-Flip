#!/bin/sh
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:/mnt/SDCARD/Apps/PortMaster/PortMaster:$LD_LIBRARY_PATH"

echo 1 >/tmp/stay_awake
/mnt/SDCARD/System/bin/text_viewer --font_file "/mnt/SDCARD/miyoo355/app/wqy-microhei.ttc" -s "/mnt/SDCARD/System/usr/miyoo/scripts/ota_update.sh"

rm /tmp/stay_awake