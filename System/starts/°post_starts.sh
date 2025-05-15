PATH="/mnt/SDCARD/System/bin:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/usr/trimui/lib:$LD_LIBRARY_PATH"

read -r current_device < /userdata/current_device.txt
if [ "$current_device" = "brick" ]; then
DeviceSuffix="_Brick"
fi
if [ "$current_device" = "miyooflip" ]; then
DeviceSuffix="_miyooflip"
fi
  # if [ "$current_device" = "tsp" ]; then
# Swap A B
# SWAP_AB_enabled=$(/mnt/SDCARD/System/bin/jq -r '["SWAP A B"]' "/mnt/SDCARD/System/etc/surwish.json")
# if [ "$SWAP_AB_enabled" -eq 1 ]; then
  # mkdir -p /var/trimui_inputd
  # touch /var/trimui_inputd/swap_ab
# fi
# fi

# Telnet service
TELNET_enabled=$(/mnt/SDCARD/System/bin/jq -r '.["TELNET"]' "/mnt/SDCARD/System/etc/surwish.json")
if [ "$TELNET_enabled" -eq 1 ]; then
	/mnt/SDCARD/System/bin/telnetd
fi

# Syncthing service
Syncthing_enabled=$(/mnt/SDCARD/System/bin/jq -r '.["Syncthing"]' "/mnt/SDCARD/System/etc/surwish.json")
if [ "$Syncthing_enabled" -eq 1 ]; then
	CONFIGPATH=/mnt/SDCARD/System/etc/syncthing
	/mnt/SDCARD/System/bin/syncthing serve --no-restart --no-upgrade --config="$CONFIGPATH" --data="$CONFIGPATH/data" &
fi

# SMB service
smb_enabled=$(/mnt/SDCARD/System/bin/jq -r '.["SMB"]' "/mnt/SDCARD/System/etc/surwish.json")
if [ "$smb_enabled" -eq 1 ]; then
	rm -rf /var/cache/samba /var/log/samba /var/lock/subsys /var/run/samba /var/lib/samba/
	PATH="/mnt/SDCARD/System/bin:$PATH"
	export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/mnt/SDCARD/Apps/PortMaster/PortMaster:/usr/miyoo/lib:$LD_LIBRARY_PATH"
	mkdir -p /tmp/samba-private/msg.sock
	chmod 700 /tmp/samba-private
	chmod 700 /tmp/samba-private/msg.sock
	mkdir -p /var/log/samba/cores
	CONFIGFILE="/mnt/SDCARD/System/etc/samba/smb.conf"
	smbd -s ${CONFIGFILE} -D
fi

# Avahi (DNS name) service
# avahi-daemon --file=/mnt/SDCARD/System/etc/avahi/avahi-daemon${DeviceSuffix}.conf  --no-drop-root -D

touch /tmp/post_start_done
