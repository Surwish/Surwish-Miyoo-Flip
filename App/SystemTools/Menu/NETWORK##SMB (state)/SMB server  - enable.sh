#!/bin/sh

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Applying \"$(basename "$0" .sh)\" by default..."

json_file="/mnt/SDCARD/System/etc/surwish.json"

if [ ! -f "$json_file" ]; then
  echo "{}" >"$json_file"
fi

/mnt/SDCARD/System/bin/jq '. += {"SMB": 1, "SMB_secure": 0}' "$json_file" >"/tmp/json_file.tmp" && mv "/tmp/json_file.tmp" "$json_file"

kill -9 $(pidof smbd)
kill -9 $(pidof nmbd)

PATH="/mnt/SDCARD/System/bin:$PATH"
CONFIGFILE="/mnt/SDCARD/System/etc/samba/smb.conf"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/usr/miyoo/lib:$LD_LIBRARY_PATH"

rm -rf /var/cache/samba /var/log/samba /var/lock/subsys /var/run/samba /var/lib/samba/
mkdir -p /var/cache/samba /var/log/samba /var/lock/subsys /var/run/samba /var/run/samba/locks /var/lib/samba/private
mkdir -p /tmp/samba-private/msg.sock
chmod 700 /tmp/samba-private
chmod 700 /tmp/samba-private/msg.sock
sync
sleep 0.3

smbd -s ${CONFIGFILE} -D
nmbd -D --configfile="${CONFIGFILE}"

# we modify the DB entries to reflect the current state
/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "SMB" "enabled"


sleep 1
IP=$(ifconfig wlan0 2>/dev/null | awk '/inet addr:/ { print substr($2, 6) }')
echo "SMB: \\\\$IP"
/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "SMB: \\\\$IP" -t 4
