#!/bin/sh
PATH="/mnt/SDCARD/System/bin:$PATH"
LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" on current theme."

CurrentTheme=$(/mnt/SDCARD/System/bin/jq -r .theme /mnt/UDISK/system.json)
cd "$CurrentTheme/sound/"
mv ./click.wav ./click-off.wav

# Menu modification to reflect the change immediately

json_file="/mnt/SDCARD/System/etc/surwish.json"
if [ ! -f "$json_file" ]; then
    echo "{}" >"$json_file"
fi

# we modify the DB entries to reflect the current state
/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "CLICK" "disabled"