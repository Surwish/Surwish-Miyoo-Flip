#!/bin/sh
LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

button=$(/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Restore PortMaster: press A to continue, B to cancel." -k "A B")

if [ "$button" = "B" ]; then
  echo "Cancel Retroarch config restore"
  /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Restore PortMaster: Canceled." -t 0.5
  exit
fi

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Restoring PortMaster configuration..."

/mnt/SDCARD/System/bin/7zz x -aoa /mnt/SDCARD/System/updates/portmaster.7z.001 -o/mnt/SDCARD/


sleep 0.1

