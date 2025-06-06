#!/bin/sh
PATH="/mnt/SDCARD/System/bin:$PATH"
LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" backgrounds by default..."

script_name=$(basename "$0" .sh)

find /mnt/SDCARD/Emus/ -name "config.json" -exec sh -c '
    bg_path="/mnt/SDCARD/Backgrounds/$1/$(basename "$(dirname "{}")").png"
    echo "bg_path $bg_path"
    /mnt/SDCARD/System/bin/jq --arg new_icon "$bg_path" ".background=\"$bg_path\"" "{}"  > /tmp/tmp_config.json && mv /tmp/tmp_config.json "{}"
' sh "$script_name" {} \;

json_file="/mnt/SDCARD/System/etc/surwish.json"
if [ ! -f "$json_file" ]; then
    echo "{}" >"$json_file"
fi
/mnt/SDCARD/System/bin/jq --arg script_name "$script_name" '. += {"BACKGROUNDS": $script_name}' "$json_file" >"/tmp/json_file.tmp" && mv "/tmp/json_file.tmp" "$json_file"

/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "BACKGROUNDS" "$script_name"
