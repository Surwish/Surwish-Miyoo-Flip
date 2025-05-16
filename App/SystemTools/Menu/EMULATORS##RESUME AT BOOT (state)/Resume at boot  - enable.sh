#!/bin/sh
PATH="/mnt/SDCARD/System/bin:$PATH"
LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" by default..."

json_file="/mnt/SDCARD/System/etc/surwish.json"

if [ ! -f "$json_file" ]; then
    echo "{}" >"$json_file"
fi

# Use jq to insert or replace the "RESUME AT BOOT" value with 1 in the JSON file
/mnt/SDCARD/System/bin/jq '. += {"RESUME AT BOOT": 1}' "$json_file" >"/tmp/json_file.tmp" && mv "/tmp/json_file.tmp" "$json_file"

# we modify the DB entries to reflect the current state
/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "RESUME AT BOOT" "enabled"
