#!/bin/sh

PATH="/mnt/SDCARD/System/bin:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/usr/miyoo/lib:$LD_LIBRARY_PATH"

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" by default..."

json_file="/mnt/SDCARD/System/etc/surwish.json"

if [ ! -f "$json_file" ]; then
  echo "{}" >"$json_file"
fi

/mnt/SDCARD/System/bin/jq '. += {"SMB": 0}' "$json_file" >"/tmp/json_file.tmp" && mv "/tmp/json_file.tmp" "$json_file"

kill -9 $(pidof smbd)
kill -9 $(pidof nmbd)

rm -rf /var/cache/samba /var/log/samba /var/lock/subsys /var/run/samba /var/lib/samba/

# we modify the DB entries to reflect the current state
/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "SMB" "disabled"
