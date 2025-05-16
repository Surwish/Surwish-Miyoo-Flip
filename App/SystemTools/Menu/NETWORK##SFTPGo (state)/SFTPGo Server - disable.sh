#!/bin/sh

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" by default..."

json_file="/mnt/SDCARD/System/etc/surwish.json"

if [ ! -f "$json_file" ]; then
    echo "{}" >"$json_file"
fi

/mnt/SDCARD/System/bin/jq '. += {"SFTPGo": 0}' "$json_file" >"/tmp/json_file.tmp" && mv "/tmp/json_file.tmp" "$json_file"


sed -i 's/export NETWORK_SFTPGO="Y"/export NETWORK_SFTPGO="N"/' /mnt/SDCARD/System/etc/ex_config
pkill /mnt/SDCARD/System/sftpgo/sftpgo

# we modify the DB entries to reflect the current state
/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "SFTPGo" "disabled"
